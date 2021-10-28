//
//  AppTabViewModel.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 10/27/21.
//

import SwiftUI
import MapKit

final class AppTabViewModel: NSObject, ObservableObject {
    
    @Published var isShowingOnboardView = false
    @Published var alertItem: AlertItem?
    
    // create this instance if Location Services are available
    var deviceLocationManager: CLLocationManager?
    // constant for userdefault key
    var kHasSeenOnboardView = "hasSeenOnboardView"
    // computed property for onboardview
    var hasSeenOnboardView: Bool { return UserDefaults.standard.bool(forKey: kHasSeenOnboardView) }
     
    //checks if the user's seen onboarding screen. false - load view. true - check location services.
    func runStartupChecks() {
        if !hasSeenOnboardView {
            isShowingOnboardView = true
            UserDefaults.standard.setValue(true, forKey: kHasSeenOnboardView)
        } else {
            checkIfLocationServicesIsEnabled()
        }
    }
    
    
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
}


// MARK: - Extensions
extension AppTabViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
