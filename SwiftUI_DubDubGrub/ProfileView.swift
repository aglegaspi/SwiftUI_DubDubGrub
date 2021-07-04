//
//  ProfileView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 6/24/21.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var firstName    = ""
    @State private var lastName     = ""
    @State private var companyName  = ""
    @State private var bio          = ""
    
    var body: some View {
        VStack {
            ZStack {
                Color(.secondarySystemBackground)
                    .frame(height: 130)
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(size: 84)
                            .padding(.leading,12)
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .offset(x: 30, y: 32)
                    }
                    
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        
                        TextField("Last Name", text: $lastName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        
                        TextField("Company Name", text: $companyName)
                        
                    }
                    .padding(.trailing, 16)
                }
                .padding()
            }
            
            VStack(alignment: .leading) {
                Text("Bio: ")
                    .font(.callout)
                    .foregroundColor(.secondary)
                +
                    Text("\(100 - bio.count)")
                    .bold()
                        .font(.callout)
                    .foregroundColor(bio.count <= 100 ? .brandPrimary : Color(.systemPink))
                +
                    Text(" characters remain")
                        .font(.callout)
                        .foregroundColor(.secondary)
                
                TextEditor(text: $bio)
                    .frame(height: 100)
                    .padding()
                
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary,lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Create Profile")
                    .bold()
                    .frame(width: 280, height: 44)
                    .background(Color.brandPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
