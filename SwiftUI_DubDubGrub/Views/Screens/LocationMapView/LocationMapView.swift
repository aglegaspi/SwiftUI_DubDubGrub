//
//  LocationMapView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 6/24/21.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationMapViewModel()
    
    var body: some View {
        
        ZStack {
            // Map takes in a parameter of a region, an array of annotion item (locations), then it's going to iterate through those locations, then drop a map pin at the coordinate, and make it the color provided.
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
                MapMarker(coordinate: location.location.coordinate, tint: .brandPrimary)
            }
                .ignoresSafeArea()
            
            VStack {
                LogoView().shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dissmissButton)
        })
        .onAppear {
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
            }
        }
        
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
    }
}

struct LogoView: View {
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(height: 70)
            
    }
}
