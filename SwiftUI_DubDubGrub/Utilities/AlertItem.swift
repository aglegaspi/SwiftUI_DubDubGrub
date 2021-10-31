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
    let dismissButton: Alert.Button
    
    var alert: Alert {
        Alert(title: title, message: message, dismissButton: dismissButton)
    }
}

struct AlertContext {
    
    //MARK: - MapView Errors
    static let unableToGetLocations = AlertItem(title: Text("Locations Error"),
                                                message: Text("Unable to retrieve locations."),
                                                dismissButton: .default(Text("OK")))
    
    static let locationRestricted = AlertItem(title: Text("Locations Restricted"),
                                                message: Text("Location restricted. Possible to parental controls."),
                                                dismissButton: .default(Text("OK")))
    
    static let locationDenied = AlertItem(title: Text("Locations Denied"),
                                                message: Text("This app does not have access to your location. To change that go to Settings > Dub Dub Grub > Location"),
                                                dismissButton: .default(Text("OK")))
    
    static let locationDisabled = AlertItem(title: Text("Location Services Disabled"),
                                                message: Text("This app location services are disabled. To change that go to Settings > Privacy > Location Services"),
                                                dismissButton: .default(Text("OK")))
    
    //MARK: - ProfileView Errors
    static let invalidProfile = AlertItem(title: Text("Invalid Profile"),
                                                message: Text("All fields are required as well as a profile photo. Your bio must be < 100 characters. \n Please try again"),
                                                dismissButton: .default(Text("OK")))
    
    static let noUserRecord = AlertItem(title: Text("No User Record"),
                                                message: Text("Must be logged on to iCloud to utilize profile. \n Please login via Settings"),
                                                dismissButton: .default(Text("OK")))
    
    static let createProfileSuccess = AlertItem(title: Text("Profile Created Successfully"),
                                                message: Text("You're profile has successfully been created."),
                                                dismissButton: .default(Text("OK")))
    
    static let createProfileFailure = AlertItem(title: Text("Failed To Create Profile"),
                                                message: Text("Unable to create profile \n Please try again later or contact us if this persists"),
                                                dismissButton: .default(Text("OK")))
    
    static let unableToGetProfile = AlertItem(title: Text("Unable to retrieve Profile"),
                                                message: Text("Please check your internet and try again. \n If probelm persists please contact us."),
                                                dismissButton: .default(Text("OK")))
    
    static let updateProfileSuccess = AlertItem(title: Text("Profile Updated Successfully"),
                                                message: Text("Your profile has been updated."),
                                                dismissButton: .default(Text("OK")))
    
    static let updateProfileFailure = AlertItem(title: Text("Failed To Update Profile"),
                                                message: Text("Unable to update your profile. \n Please Try again"),
                                                dismissButton: .default(Text("OK")))
    
    //MARK: - LocationDetailView Errors
    static let invalidPhoneNumber = AlertItem(title: Text("Invalid Phone Number"),
                                                message: Text("Phone number for location is invalid."),
                                                dismissButton: .default(Text("OK")))
    
    static let unableToGetCheckinStatus = AlertItem(title: Text("Server Error"),
                                                message: Text("Unable to retrieve checked in status.\n Please try again"),
                                                dismissButton: .default(Text("OK")))
    
    static let unableToGetCheckInOrOut = AlertItem(title: Text("Server Error"),
                                                message: Text("Unable to check in or out at this time.\n Please try again"),
                                                dismissButton: .default(Text("OK")))
    
    static let unableToGetCheckedInProfiles = AlertItem(title: Text("Server Error"),
                                                message: Text("Unable to get users checked in at this location at this time."),
                                                dismissButton: .default(Text("OK")))
}
