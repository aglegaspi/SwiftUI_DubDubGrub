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
    
    static let noUserRecord = AlertItem(title: Text("No User Record"),
                                                message: Text("Must be logged on to iCloud to utilize profile. \n Please login via Settings"),
                                                dissmissButton: .default(Text("OK")))
    
    static let createProfileSuccess = AlertItem(title: Text("Profile Created Successfully"),
                                                message: Text("You're profile has successfully been created."),
                                                dissmissButton: .default(Text("OK")))
    
    static let createProfileFailure = AlertItem(title: Text("Failed To Create Profile"),
                                                message: Text("Unable to create profile \n Please try again later or contact us if this persists"),
                                                dissmissButton: .default(Text("OK")))
    
    static let unableToGetProfile = AlertItem(title: Text("Unable to retrieve Profile"),
                                                message: Text("Please check your internet and try again. \n If probelm persists please contact us."),
                                                dissmissButton: .default(Text("OK")))
    
    static let updateProfileSuccess = AlertItem(title: Text("Profile Updated Successfully"),
                                                message: Text("Your profile has been updated."),
                                                dissmissButton: .default(Text("OK")))
    
    static let updateProfileFailure = AlertItem(title: Text("Failed To Update Profile"),
                                                message: Text("Unable to update your profile. \n Please Try again"),
                                                dissmissButton: .default(Text("OK")))
    
}
