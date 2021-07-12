//
//  LocationMapView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 6/24/21.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516,
                                                                                  longitude: -121.891054),
                                                   //How much to zoom in
                                                   span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
            
            VStack {
                LogoView()
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                Spacer()
            }
        }
        .onAppear {
            CloudKitManager.getLocations { result in
                switch result {
                case .success(let locations):
                    print(locations)
                case .failure(let error):
                    print(error.localizedDescription)
                }
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
