//
//  LocationMapViewModel.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 7/26/21.
//

import SwiftUI
import MapKit

final class LocationMapViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516,
                                                                              longitude: -121.891054),
                                               //How much to zoom in
                                               span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    // create this instance if Location Services are available
    var deviceLocationManager: CLLocationManager?
    
    // check if Location Services are enable and create the instance
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            deviceLocationManager = CLLocationManager()
        }
    }
    
    func getLocations(for locationManager: LocationManager) {
        CloudKitManager.getLocations { result in
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
    
}
