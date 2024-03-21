//
//  ContentView.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/15/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = AppViewModel.shared
    
    var body: some View {
        
        ZStack {
            
            ContainerRelativeShape()
                .fill(Color.primaryColor)
                .ignoresSafeArea()
            
            switch viewModel.selectedView {
                
            case .register:
                RegisterView()
                
            case .login:
                LoginView()
                
            case .recipes:
                RecipesView()
                
            case .profile:
                ProfileView()
                
            }
            
        }
        .overlay(Sidebar())
        .overlay(
            Image(systemName: "line.3.horizontal")
                .resizable()
                .foregroundStyle(.white)
                .scaledToFit()
                .frame(width: 30)
                .padding(.top, 26)
                .padding(.horizontal, 20)
                .onTapGesture{viewModel.sidebarOpen.toggle()}
                .opacity(viewModel.hideNav ? 0 : 1),
            alignment: .topTrailing
        )
    }
}

#Preview {
    ContentView()
}
