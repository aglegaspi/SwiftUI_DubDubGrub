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
}
