//
//  AppTabView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 6/24/21.
//

import SwiftUI

struct AppTabView: View {
    
@StateObject private var viewModel = AppTabViewModel()
 
    var body: some View {
        TabView {
            LocationMapView()
                .tabItem { Label("Map", systemImage: "map") }
            
            LocationListView()
                .tabItem { Label("Locations", systemImage: "building") }
            
            NavigationView {
                ProfileView()
            }
            .tabItem { Label("Profile", systemImage: "person") }
        }
        .onAppear {
            viewModel.runStartupChecks()
            CloudKitManager.shared.getUserRecord()
        }
        .accentColor(.brandPrimary)
        .sheet(isPresented: $viewModel.isShowingOnboardView, onDismiss: viewModel.checkIfLocationServicesIsEnabled) {
            OnboardView(isShowingOnboardView: $viewModel.isShowingOnboardView)
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}


