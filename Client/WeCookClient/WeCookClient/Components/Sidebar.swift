//
//  Sidebar.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct Sidebar: View {
    @ObservedObject var viewModel = AppViewModel.shared
    @ObservedObject var authModel = AuthViewModel.shared
    var body: some View {
        ZStack {
            
            ContainerRelativeShape()
                .fill(.black.opacity(0.6))
                .opacity(viewModel.sidebarOpen ? 1 : 0)
                .animation(.easeInOut.delay(0.2), value: viewModel.sidebarOpen)
                .onTapGesture { viewModel.sidebarOpen = false }
            
            GeometryReader { shape in
                let width = shape.size.width*0.6
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .frame(width:width)
                    // Put tabs here
                    VStack {
                        if let uiImage = authModel.uiImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width:width*0.4,height: width*0.4)
                                .foregroundStyle(Color.primaryColor)
                                .padding(.bottom)
                        } else {
                            AsyncImage(url: URL(string: "\(NetworkManager.userImageURL)\(AuthViewModel.shared.user.id)")){ image in
                                
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width:width*0.4,height: width*0.4)
                                    .foregroundStyle(Color.primaryColor)
                                    .padding(.bottom)
                            } placeholder: {
                                Image("pfp")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:width*0.4)
                                    .foregroundStyle(Color.primaryColor)
                                    .padding(.bottom)
                                    .clipShape(Circle())
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            NavItem(title: "Recipes", imageName: "book.pages.fill")
                                .onTapGesture {
                                    viewModel.selectedView = .recipes
                                    viewModel.sidebarOpen = false
                                }
                            
                            NavItem(title: "Profile", imageName: "person.circle")
                                .onTapGesture {
                                    viewModel.selectedView = .profile
                                    viewModel.sidebarOpen = false
                                }
                            NavItem(title: "Logout", imageName: "rectangle.portrait.and.arrow.right")
                                .onTapGesture {
                                    Task {
                                        await authModel.logout()
                                        viewModel.selectedView = .login
                                        viewModel.sidebarOpen = false
                                    }
                                }
                        }
                        
                        Spacer()
                    }
                    .padding(.top,shape.size.height*0.15)
                }
                .offset(x: viewModel.sidebarOpen ? 0 : -width)
                .animation(.default.speed(0.6), value: viewModel.sidebarOpen)
            }
            
        }.ignoresSafeArea()
    }
}

struct NavItem: View {
    
    var title: String
    var imageName: String
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width:20)
                .foregroundStyle(Color.primaryGreen)
            Text(title)
                .foregroundStyle(.black)
                .font(.system(size: 22))
                .padding(5)
        }
    }
    
}

                          
#Preview {
    Sidebar()
}
