//
//  LocationManager.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 9/1/21.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
    var selectedLocation: DDGLocation?
}
