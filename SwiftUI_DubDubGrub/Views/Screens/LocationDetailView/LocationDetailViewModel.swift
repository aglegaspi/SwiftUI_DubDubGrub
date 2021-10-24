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

final class LocationDetailViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [DDGProfile] = []
    @Published var isCheckedIn = false
    @Published var alertItem: AlertItem?
    @Published var isShowingProfileModal: Bool = false
    
    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var location: DDGLocation
    
    init(location: DDGLocation) {
        self.location = location
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
    
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        // Retrieve the DDGProfile
        
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            print("couldn't get profile id")
            return
        }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result in
            switch result {
            case .success(let record):
                switch checkInStatus {
                    
                case .checkedIn:
                    record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                case .checkedOut:
                    record[DDGProfile.kIsCheckedIn] = nil
                }
                
                // Save the updated profile to CloudKit
                CloudKitManager.shared.save(record: record) { [self] result in
                    
                    DispatchQueue.main.async {
                        switch result {
                            case .success(_):
                                // update our checkedInProfiles array
                                let profile = DDGProfile(record: record)
                            
                                switch checkInStatus {
                                    case .checkedIn:
                                        checkedInProfiles.append(profile)
                                    case .checkedOut:
                                        checkedInProfiles.removeAll(where: { $0.id == profile.id })
                                } // switch checkInStatus
                                isCheckedIn = !isCheckedIn
                            
                                print("✅ checked in/out successfully")
                            case .failure(_):
                                print("😫 checked in/out failed to save")
                        } // switch result
                    } // dispatchqueue
                } // cloudkitmanager
                
            case .failure(_):
                print("😫 error fetching record")
                
            }
        }
    } // updateCheckInStatus()
    
    // Create a reference to the locations
    func getCheckedInProfiles() {
        CloudKitManager.shared.getCheckedInProfiles(for: location.id) { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let profiles):
                    self.checkedInProfiles = profiles
                case .failure(_):
                    print("error fetching checkedIn profiles")
                }
            }
        }
    } // getCheckedInProfiles()
    
}
