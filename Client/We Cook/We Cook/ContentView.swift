//
//  ContentView.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    @State var sidebarOpen = false
    var body: some View {
        NavigationStack{
            ZStack{
                ContainerRelativeShape()
                .fill(Color("Primary"))
                    .ignoresSafeArea()
                RecipesHome(sidebarOpen: $sidebarOpen)
                Sidebar(sidebarOpen: $sidebarOpen)
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.portrait)
    }
}
