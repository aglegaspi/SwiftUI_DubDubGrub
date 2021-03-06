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

@MainActor final class LocationDetailViewModel: ObservableObject {
    
    var userHasProfile = false
    @Published var checkedInProfiles: [DDGProfile] = []
    @Published var isCheckedIn = false
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    @Published var isShowingProfileSheet: Bool = false
    @Published var isShowingProfileModal: Bool = false
    
    var location: DDGLocation
    var selectedProfile: DDGProfile?
    var buttonColor: Color { isCheckedIn ? .grubRed : .brandPrimary }
    var buttonImageTitle: String { isCheckedIn ? "person.fill.xmark" : "person.fill.checkmark" }
    var buttonA11yLabel: String { isCheckedIn ? "Check out of location" : "Check in to location" }
    
    init(location: DDGLocation) { self.location = location }
    
    
    func determineColumns(for dynamicTypeSize: DynamicTypeSize) -> [GridItem] {
        let numberOfColumns = dynamicTypeSize >= .accessibility3 ? 2 : 3
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
                
        Task {
            do {
                let record = try await CloudKitManager.shared.fetchRecord(with: profileRecordID)
                if let _ = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                    isCheckedIn = true
                } else {
                    isCheckedIn = false
                }
            } catch { alertItem = AlertContext.unableToGetCheckinStatus}
        }
    } //getCheckedInStatus
    
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            alertItem = AlertContext.unableToGetProfile
            return
        }
        showLoadingView()
        
        Task {
            do {
                let record = try await CloudKitManager.shared.fetchRecord(with: profileRecordID)
                switch checkInStatus {
                case .checkedIn:
                    record[DDGProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                    record[DDGProfile.kIsCheckedInNilCheck] = 1
                case .checkedOut:
                    record[DDGProfile.kIsCheckedIn] = nil
                    record[DDGProfile.kIsCheckedInNilCheck] = nil
                }
                
                let savedRecord = try await CloudKitManager.shared.save(record: record)
                HapticManager.playSuccess()
                
                let profile = DDGProfile(record: savedRecord)
                switch checkInStatus {
                case .checkedIn:
                    checkedInProfiles.append(profile)
                case .checkedOut:
                    checkedInProfiles.removeAll(where: { $0.id == profile.id })
                } 
                
                isCheckedIn.toggle()
                hideLoadingView()
            } catch {
                hideLoadingView()
                alertItem = AlertContext.unableToGetCheckInOrOut
            }
        }
        

    } // updateCheckInStatus()
    
    
    // Create a reference to the locations
    func getCheckedInProfiles() {
        showLoadingView()
        
        Task {
            hideLoadingView()
            do {
                checkedInProfiles = try await CloudKitManager.shared.getCheckedInProfiles(for: location.id)
            } catch {
                alertItem = AlertContext.unableToGetCheckedInProfiles
            }
        }

    } // getCheckedInProfiles()
    
    
    func show(_ profile: DDGProfile, in dynamicTypeSize: DynamicTypeSize) {
        selectedProfile = profile
        if dynamicTypeSize >= .accessibility3 {
            isShowingProfileSheet = true
        } else {
            isShowingProfileModal = true
        }
    }
    
    private func showLoadingView() { isLoading = true }
    private func hideLoadingView() { isLoading = false }
}



