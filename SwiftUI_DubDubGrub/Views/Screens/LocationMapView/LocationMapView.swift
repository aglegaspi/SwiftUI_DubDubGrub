//
//  LocationMapView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 6/24/21.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @StateObject private var viewModel = LocationMapViewModel()
    
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $viewModel.region).ignoresSafeArea()
            
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
            viewModel.getLocations()
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
