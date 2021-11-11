//
//  AppTabViewModel.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 10/27/21.
//

import SwiftUI
import CoreLocation

extension AppTabView {
    
    final class AppTabViewModel: ObservableObject {
        
        @Published var isShowingOnboardView = false
        @AppStorage("hasSeenOnboardView") var hasSeenOnboardView = false {
            didSet { isShowingOnboardView = hasSeenOnboardView }
        }
    
        // constant for userdefault key
        var kHasSeenOnboardView = "hasSeenOnboardView"

        //checks if the user's seen onboarding screen. false - load view. true - check location services.
        func checkIfHasSeenOnboard() {
            if !hasSeenOnboardView {  hasSeenOnboardView = true }
        }
     
    } //apptabviewmodel
    
} //extension


