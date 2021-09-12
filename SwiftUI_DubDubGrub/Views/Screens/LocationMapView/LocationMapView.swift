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
            .accentColor(.grubRed)
            .ignoresSafeArea()
            
            VStack {
                LogoView(frameWidth: 125)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }
        .sheet(isPresented: $viewModel.isShowingOnboardView, content: {
            OnboardView(isShowingOnboardView: $viewModel.isShowingOnboardView)
        })
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dissmissButton)
        })
        .onAppear {
            viewModel.checkIfLocationServicesIsEnabled()
            
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


