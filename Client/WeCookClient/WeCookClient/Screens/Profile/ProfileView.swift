//
//  ProfileView.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @ObservedObject var viewModel = AppViewModel.shared
    @ObservedObject var authModel = AuthViewModel.shared
    @State var isEditing = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ContainerRelativeShape()
                    .fill(Color.primaryColor)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Profile")
                            .foregroundStyle(.white)
                            .font(.system(size: 52, weight: .bold, design: .default))
                        Spacer()
                    }
                    HStack {
                        PhotosPicker(selection: $authModel.imageData) {
                            if let uiImage = authModel.uiImage {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width:150,height:150)
                                    .clipShape(Circle())
                            }
                            else{
                                AsyncImage(url: URL(string: "\(NetworkManager.userImageURL)\(AuthViewModel.shared.user.id)")){ image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width:150,height:150)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Image("pfp")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:150,height:150)
                                        .foregroundStyle(Color.primaryColor)
                                        .padding(.bottom)
                                        .clipShape(Circle())
                                }
                            }
                        }.disabled(!isEditing)
                        VStack(alignment: .leading){
                            Text("\(authModel.user.fName) \(authModel.user.lName)")
                                .foregroundStyle(.white)
                                .font(.system(size: 30, weight: .semibold, design: .default))
                            Button {
                                Task {
                                    do {
                                        if isEditing {
                                            try await authModel.saveChanges()
                                        }
                                        isEditing.toggle()
                                    } catch {
                                        print("Error when saving changes \(error)")
                                    }
                                }
                            } label:{
                                Text(isEditing ? "Save changes" : "Edit Profile")
                                    .font(.system(size: 15))
                                    .foregroundStyle(.white)
                            }
                        }
                        Spacer()
                    }.padding(.bottom)
                    VStack(spacing: 25) {
                        TextField("Bio", text: $authModel.user.bio,axis: .vertical)
                            .disabled(!isEditing)
                            .foregroundStyle(.black)
                        Divider()
                        TextField("Email", text: $authModel.user.email)
                            .disabled(!isEditing)
                            .foregroundStyle(.black)
                        Divider()
                        TextField("First Name", text: $authModel.user.fName)
                            .disabled(!isEditing)
                            .foregroundStyle(.black)
                        Divider()
                        TextField("Last Name", text: $authModel.user.lName)
                            .disabled(!isEditing)
                            .foregroundStyle(.black)
                    }
                    .ignoresSafeArea(.keyboard)
                    .padding(.all,15)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal,6)
                    
                    Spacer()
                }
                .padding(.horizontal,8)
                
//                Button {
//                    Task {
//                        await authModel.logout()
//                        viewModel.selectedView = .login
//                    }
//                }label: {
//                    Text("logout")
//                        .font(.title)
//                }
//                Text("\(authModel.user.fName) \(authModel.user.lName)")
            }
            .navigationTitle("Profile")
            .toolbar(.hidden)
        }

    }
}

#Preview {
    ProfileView()
}
