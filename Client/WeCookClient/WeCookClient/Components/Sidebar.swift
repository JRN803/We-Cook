//
//  Sidebar.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct Sidebar: View {
    
    @Binding var isOpen: Bool
    @Binding var selectedView: Views

    var body: some View {
        ZStack {
            
            ContainerRelativeShape()
                .fill(.black.opacity(0.6))
                .opacity(isOpen ? 1 : 0)
                .animation(.easeInOut.delay(0.2), value: isOpen)
                .onTapGesture { isOpen = !isOpen }
            
            GeometryReader { shape in
                let width = shape.size.width*0.6
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .frame(width:width)
                    // Put tabs here
                    VStack {
                        
                        Image("pfp")
                            .resizable()
                            .scaledToFit()
                            .frame(width:width*0.4)
                            .foregroundStyle(Color.primaryColor)
                            .padding(.bottom)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            NavItem(title: "Recipes", imageName: "book.pages.fill")
                                .onTapGesture {
                                    selectedView = .recipes
                                    isOpen = false
                                }
                            
                            NavItem(title: "Profile", imageName: "person.circle")
                                .onTapGesture {
                                    selectedView = .profile
                                    isOpen = false
                                }
                        }
                        
                        Spacer()
                    }
                    .padding(.top,shape.size.height*0.15)
                }
                .offset(x: isOpen ? 0 : -width)
                .animation(.default.speed(0.6), value: isOpen)
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
                .font(.system(size: 22))
                .padding(5)
        }
    }
    
}

                          
#Preview {
    Sidebar(isOpen: .constant(true),selectedView: .constant(.recipes))
}
