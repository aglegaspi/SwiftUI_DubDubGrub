//
//  SwiftUI_DubDubGrubApp.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 6/20/21.
//

import SwiftUI

@main
struct SwiftUI_DubDubGrubApp: App {
    
    let locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(locationManager)
        }
    }
}
