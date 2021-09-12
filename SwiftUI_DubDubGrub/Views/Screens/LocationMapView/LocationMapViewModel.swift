//
//  LocationMapViewModel.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 7/26/21.
//

import SwiftUI
import MapKit

final class LocationMapViewModel: NSObject, ObservableObject {
    
    @Published var isShowingOnboardView = true
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
            
            // force unwrapped because the instance is created at this point
            deviceLocationManager!.delegate = self
        } else {
            alertItem = AlertContext.locationDisabled
        }
    }
    
    // check for app specific permission
    private func checkLocationAuthorization() {
        guard let deviceLocationManager = deviceLocationManager else { return }
        
        switch deviceLocationManager.authorizationStatus {
        
        case .notDetermined:
            deviceLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.locationRestricted
            return
        case .denied:
            alertItem = AlertContext.locationDenied
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
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

// MARK: - Extensions
extension LocationMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
