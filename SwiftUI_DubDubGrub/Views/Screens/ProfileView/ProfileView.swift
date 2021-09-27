//
//  ProfileView.swift
//  SwiftUI_DubDubGrub
//
//  Created by Alex 6.1 on 6/24/21.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                NameBackgroundView()
                
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(image: viewModel.avatar, size: 84)
                        EditImage()
                    }
                    .padding(.leading,12)
                    .onTapGesture { viewModel.isShowingPhotoPicker = true }
                    
                    VStack(spacing: 1) {
                        TextField("First Name", text: $viewModel.firstName).profileNameStyle()
                        TextField("Last Name", text: $viewModel.lastName).profileNameStyle()
                        TextField("Company Name", text: $viewModel.companyName)
                    }
                    .padding(.trailing, 16)
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                CharactersRemainView(currentCount: viewModel.bio.count)
                
                TextEditor(text: $viewModel.bio)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button {
                //createProfile()
                
            } label: {
                DDGButton(title: "Create Profile")
            }
            .padding(.bottom)
        } // VStack
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
            
        } // toolbar
        .onAppear { viewModel.getProfile() }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dissmissButton)
        }) // alert
        .sheet(isPresented: $viewModel.isShowingPhotoPicker) {
            // when picture is selected it'll be set to avatar
            PhotoPicker(image: $viewModel.avatar)
        } // sheet
    } // body
    
}//struct



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}


struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

struct EditImage: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundColor(.black)
            .offset(x: 30, y: 32)
    }
}

struct CharactersRemainView: View {
    
    var currentCount: Int
    
    var body: some View {
        Text("Bio: ")
            .font(.callout)
            .foregroundColor(.secondary)
            +
            Text("\(100 - currentCount)")
            .bold()
            .font(.callout)
            .foregroundColor(currentCount <= 100 ? .brandPrimary : Color(.systemPink))
            +
            Text(" characters remain")
            .font(.callout)
            .foregroundColor(.secondary)
    }
}
