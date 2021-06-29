//
//  LocationDetailView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 6/29/21.
//

import SwiftUI

struct LocationDetailView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Image("default-banner-asset")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                
                HStack {
                    Label("123 Main Street", systemImage: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.horizontal)
                
                Text("This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. This is a test description. ")
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                    .padding(.horizontal)
                
                ZStack {
                    Capsule()
                        .frame(height: 80)
                        .foregroundColor(Color(.secondarySystemBackground))
                    
                    HStack {
                        ZStack {
                            Circle()
                                .foregroundColor(.brandPrimary)
                                .frame(width: 60, height: 60)
                            Image(systemName: "location.fill")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 22, height: 22)
                        }
                    }
                }
                .padding(.horizontal)
                    
                Spacer()
                
            }
            .navigationTitle("Location Name")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView()
    }
}
