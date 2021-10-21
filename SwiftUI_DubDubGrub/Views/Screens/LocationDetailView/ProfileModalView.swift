//
//  ProfileModalView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 10/21/21.
//

import SwiftUI

struct ProfileModalView: View {
    
    @Binding var isShowingProfileModal: Bool
    var profile: DDGProfile
    
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 60)
                
                Text(profile.firstName + " " + profile.lastName)
                    .bold()
                    .font(.title2)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
                
                Text(profile.companyName)
                    .bold()
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(.secondary)
                
                Text(profile.bio)
                    .lineLimit(3)
                    .padding()
            }
            .frame(width: 300, height: 230)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .overlay(
                Button {
                    isShowingProfileModal = false
                } label: {
                    XDismissButton()
                }, alignment: .topTrailing )
            
            Image(uiImage: profile.convertAvatarImage())
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.5), radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 0.6)
                .offset(y: -140)
        }
    }
}

struct ProfileModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModalView(isShowingProfileModal: .constant(true), profile: DDGProfile(record: MockData.profile))
    }
}