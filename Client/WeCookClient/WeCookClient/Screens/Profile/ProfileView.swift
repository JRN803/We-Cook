//
//  ProfileView.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                ContainerRelativeShape()
                    .fill(Color.primaryColor)
                    .ignoresSafeArea()
                Text("Hello, From profile!")
                    .navigationTitle("Profile")
            }
            .navigationTitle("Profile")
            .toolbar(.hidden)
        }
    }
}

#Preview {
    ProfileView()
}
