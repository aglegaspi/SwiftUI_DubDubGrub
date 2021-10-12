//
//  LocationDetailView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 6/29/21.
//

import SwiftUI

struct LocationDetailView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
            VStack(spacing: 16) {
                BannerImageView(image: viewModel.location.createBannerImage())
                
                HStack {
                    Label(viewModel.location.address, systemImage: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                DescriptionView(text: viewModel.location.description)
                
                ZStack {
                    Capsule()
                        .frame(height: 80)
                        .foregroundColor(Color(.secondarySystemBackground))
                    
                    HStack(spacing: 20) {
                        Button {
                            
                        } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                        }
                        
                        Link(destination: URL(string: viewModel.location.websiteURL)!, label: {
                            LocationActionButton(color: .brandPrimary, imageName: "network")
                        })
                        
                        Button {
                            
                        } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
                        }
                        
                        Button {
                            
                        } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "person.fill.checkmark")
                        }
                    }
                }
                .padding(.horizontal)
                
                Text("Who's Here?")
                    .bold()
                    .font(.title2)
                
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, content: {
                        FirstNameAvatarView(firstName: "Alex")
                        FirstNameAvatarView(firstName: "Sean")
                        FirstNameAvatarView(firstName: "Lex")
                        FirstNameAvatarView(firstName: "Dawn")
                        FirstNameAvatarView(firstName: "Steven")
                        FirstNameAvatarView(firstName: "Alexa")
                        FirstNameAvatarView(firstName: "Alexis")
                        FirstNameAvatarView(firstName: "Alexandria")
                        FirstNameAvatarView(firstName: "Cindy")
                    })
                }
                    
                Spacer()
                
            }
            .navigationTitle(viewModel.location.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView(viewModel: LocationDetailViewModel(location: DDGLocation(record: MockData.location)) )
    }
}

struct LocationActionButton: View {
    
    var color: Color
    var imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 60, height: 60)
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 22, height: 22)
        }
    }
}

struct FirstNameAvatarView: View {
    
    var firstName: String
    
    var body: some View {
        VStack {
            AvatarView(image: PlaceholderImage.avatar, size: 64)
            
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

struct BannerImageView: View {
    
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct DescriptionView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .frame(height: 70)
            .padding(.horizontal)
    }
}
