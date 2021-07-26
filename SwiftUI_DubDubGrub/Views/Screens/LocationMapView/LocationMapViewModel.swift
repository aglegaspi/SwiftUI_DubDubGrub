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
    @Published var locations: [DDGLocation] = []
    
    func getLocations() {
        CloudKitManager.getLocations { result in
            switch result {
            case .success(let locations):
                print(locations)
            case .failure(_):
                self.alertItem = AlertContext.unableToGetLocations
            }
        }
    }
    
}
