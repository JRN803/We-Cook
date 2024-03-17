//
//  ContentView.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/15/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var sidebarOpen = false
    @State var selectedView: Views = .recipes

    var body: some View {
        
        ZStack {
            
            ContainerRelativeShape()
                .fill(Color.primaryColor)
                .ignoresSafeArea()
            
            switch selectedView {
                
            case .recipes:
                RecipesView()
                
            case .profile:
                ProfileView()
                
            }
            
        }
        .overlay(Sidebar(isOpen: $sidebarOpen,selectedView: $selectedView))
        .overlay(
            Image(systemName: "line.3.horizontal")
                .resizable()
                .foregroundStyle(.white)
                .scaledToFit()
                .frame(width: 30)
                .padding()
                .onTapGesture{sidebarOpen.toggle()},
            alignment: .topTrailing
        )
    }
}

#Preview {
    ContentView()
}
