//
//  LocationDetailViewModel.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 10/12/21.
//

import SwiftUI
import MapKit
import CloudKit

enum CheckInStatus { case checkedIn, checkedOut }

extension LocationDetailView {
    
    final class LocationDetailViewModel: ObservableObject {
        
        var userHasProfile = false
        @Published var checkedInProfiles: [DDGProfile] = []
        @Published var isCheckedIn = false
        @Published var isLoading = false
        @Published var alertItem: AlertItem?
        @Published var isShowingProfileSheet: Bool = false
        @Published var isShowingProfileModal: Bool = false
        
        var location: DDGLocation
        var selectedProfile: DDGProfile?
        
        init(location: DDGLocation) { self.location = location }
        
        
        func determineColumns(for sizeCategory: ContentSizeCategory) -> [GridItem] {
            let numberOfColumns = sizeCategory >= .accessibilityLarge ? 2 : 3
            return Array(repeating: GridItem(.flexible()), count: numberOfColumns)
        }
        
        
        func getDirectionsToLocation() {
            let placemark = MKPlacemark(coordinate: location.location.coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = location.name
            
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
        } // getDirectionsToLocation()
        
        
        func callLocation() {
            guard let url = URL(string: "tel://\(location.phoneNumber)") else {
                alertItem = AlertContext.invalidPhoneNumber
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
            
        } // callLocation()
        
        
        func getCheckedInStatus() {
            guard let profileRecordID = CloudKitManager.shared.profileRecordID else { return }
            userHasProfile = true
            
            CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let record):
                        if let reference = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                            isCheckedIn = reference.recordID == location.id
                        } else {
                            isCheckedIn = false
                        }
                    case .failure(_):
                        alertItem = AlertContext.unableToGetCheckinStatus
                    }
                }
            }
        } //getCheckedInStatus
        
        
        func updateCheckInStatus(to checkInStatus: CheckInStatus) {
            // Retrieve the DDGProfile
            
            guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
                alertItem = AlertContext.unableToGetProfile
                return
            }
            
            CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
                switch result {
                case .success(let record):
                    switch checkInStatus {
                    case .checkedIn:
                        record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                        record[DDGProfile.kIsCheckedInNilCheck] = 1
                    case .checkedOut:
                        record[DDGProfile.kIsCheckedIn] = nil
                        record[DDGProfile.kIsCheckedInNilCheck] = nil
                    }
                    
                    // Save the updated profile to CloudKit
                    CloudKitManager.shared.save(record: record) { [self] result in
                        
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let record):
                                // update our checkedInProfiles array
                                let profile = DDGProfile(record: record)
                                
                                switch checkInStatus {
                                case .checkedIn:
                                    checkedInProfiles.append(profile)
                                case .checkedOut:
                                    checkedInProfiles.removeAll(where: { $0.id == profile.id })
                                } // switch checkInStatus
                                isCheckedIn = !isCheckedIn
                            case .failure(_):
                                alertItem = AlertContext.updateProfileFailure
                            } // switch result
                        } // dispatchqueue
                    } // cloudkitmanager
                    
                case .failure(_):
                    alertItem = AlertContext.unableToGetCheckInOrOut
                    
                }
            }
        } // updateCheckInStatus()
        
        
        // Create a reference to the locations
        func getCheckedInProfiles() {
            showLoadingView()
            CloudKitManager.shared.getCheckedInProfiles(for: location.id) { [self] result in
                DispatchQueue.main.async {
                    switch result {
                        
                    case .success(let profiles):
                        self.checkedInProfiles = profiles
                    case .failure(_):
                        alertItem = AlertContext.unableToGetCheckedInProfiles
                    }
                    
                    hideLoadingView()
                }
            }
        } // getCheckedInProfiles()
        
        
        func show(profile: DDGProfile, in sizeCategory: ContentSizeCategory) {
            selectedProfile = profile
            if sizeCategory >= .accessibilityLarge {
                isShowingProfileSheet = true
            } else {
                isShowingProfileModal = true
            }
        }
        
        private func showLoadingView() { isLoading = true }
        private func hideLoadingView() { isLoading = false }
    }
    
}


