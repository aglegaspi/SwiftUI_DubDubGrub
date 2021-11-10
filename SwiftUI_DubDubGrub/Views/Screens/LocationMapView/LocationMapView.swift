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
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        
        ZStack(alignment: .top) {
            // Map takes in a parameter of a region, an array of annotion item (locations), then it's going to iterate through those locations, then drop a map pin at the coordinate, and make it the color provided.
            Map(coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: locationManager.locations) { location in
                MapAnnotation(coordinate: location.location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.75)) {
                    DDGAnnotation(location: location,
                                  number: viewModel.checkedInProfiles[location.id, default: 0])
                        .onTapGesture {
                            locationManager.selectedLocation = location
                            viewModel.isShowingDetailView = true
                        }
                }
                
            }
            .accentColor(.grubRed)
            .ignoresSafeArea()
            
            LogoView(frameWidth: 125).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
        .sheet(isPresented: $viewModel.isShowingDetailView) {
            if let selectedLocation = locationManager.selectedLocation {
                NavigationView {
                    viewModel.createLocationDetailView(for: locationManager.selectedLocation!, in: dynamicTypeSize)
                        .toolbar { Button("Dismiss") { viewModel.isShowingDetailView = false } }
                }
            } else {
                #warning("Create Empty State Sheet or Alert")
            }
            
        }
        .alert(item: $viewModel.alertItem) { $0.alert }
        .onAppear {
            if locationManager.locations.isEmpty { viewModel.getLocations(for: locationManager) }
            viewModel.getCheckedInCount()
        }
        
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView().environmentObject(LocationManager())
    }
}


