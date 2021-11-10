//
//  LocationMapViewModel.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 7/26/21.
//

import SwiftUI
import CloudKit
import MapKit

extension LocationMapView {
    
    final class LocationMapViewModel: ObservableObject {
        
        @Published var checkedInProfiles: [CKRecord.ID: Int] = [:]
        @Published var isShowingDetailView = false
        @Published var alertItem: AlertItem?
        @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516,
                                                                                  longitude: -121.891054),
                                                   //How much to zoom in
                                                   span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        func getLocations(for locationManager: LocationManager) {
            CloudKitManager.shared.getLocations { result in
                // update UI on the main thread. Each update triggers an update on the UI
                DispatchQueue.main.async {
                    switch result {
                case .success(let locations):
                    locationManager.locations = locations
                case .failure(_):
                    self.alertItem = AlertContext.unableToGetLocations
                }}
            }
        }
        
        
        func getCheckedInCount() {
            CloudKitManager.shared.getCheckedInProfilesCount { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let retrievedCheckedInProfiles):
                        self.checkedInProfiles = retrievedCheckedInProfiles
                    case .failure(_):
                        self.alertItem = AlertContext.checkedInCount
                    }
                }
            }
        }
        
        
        @ViewBuilder func createLocationDetailView(for location: DDGLocation, in dynamicTypeSize: DynamicTypeSize) -> some View {
            if dynamicTypeSize >= .accessibility3 {
                LocationDetailView(viewModel: LocationDetailViewModel(location: location)).embedInScrollView()
            } else {
                LocationDetailView(viewModel: LocationDetailViewModel(location: location))
            }
        }
        
    }
    
}
