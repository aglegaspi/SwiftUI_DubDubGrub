//
//  LocationListView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 6/24/21.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locationManager.locations, id: \.id) { location in
                    NavigationLink(destination: LocationDetailView(viewModel: LocationDetailViewModel(location: location))) {
                        LocationCell(location: location,
                                     profiles: viewModel.checkedInProfiles[location.id, default: []])
                        }
                }
            }
            .navigationTitle("Grub Spots")
            .onAppear {
                viewModel.getCheckedInProfilesDictionary()
            }
        }
        
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}



