//
//  AlertItem.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 7/13/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dissmissButton: Alert.Button
}

struct AlertContext {
    
    //MARK: - MapView Errors
    static let unableToGetLocations = AlertItem(title: Text("Locations Error"),
                                                message: Text("Unable to retrieve locations."),
                                                dissmissButton: .default(Text("OK")))
    
    static let locationRestricted = AlertItem(title: Text("Locations Restricted"),
                                                message: Text("Location restricted. Possible to parental controls."),
                                                dissmissButton: .default(Text("OK")))
    
    static let locationDenied = AlertItem(title: Text("Locations Denied"),
                                                message: Text("This app does not have access to your location. To change that go to Settings > Dub Dub Grub > Location"),
                                                dissmissButton: .default(Text("OK")))
    
    static let locationDisabled = AlertItem(title: Text("Location Services Disabled"),
                                                message: Text("This app location services are disabled. To change that go to Settings > Privacy > Location Services"),
                                                dissmissButton: .default(Text("OK")))
    
    //MARK: - ProfileView Errors
    static let invalidProfile = AlertItem(title: Text("Invalid Profile"),
                                                message: Text("All fields are required as well as a profile photo. Your bio must be < 100 characters. \n Please try again"),
                                                dissmissButton: .default(Text("OK")))
    
}
