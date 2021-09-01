//
//  LocationListView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 6/24/21.
//

import SwiftUI

struct LocationListView: View {
    
    @State private var locations: [DDGLocation] = [DDGLocation.init(record: MockData.location)]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locations, id: \.id) { location in
                    NavigationLink(destination: LocationDetailView(location: location)) {
                        LocationCell(location: location)
                        }
                }
            }
            .navigationTitle("Grub Spots")
        }
        
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}




