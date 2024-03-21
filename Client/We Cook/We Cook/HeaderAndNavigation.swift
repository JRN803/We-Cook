//
//  HeaderAndNavigation.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/6/24.
//

import SwiftUI

struct HeaderAndNavigation: View {
    @Binding var sidebarOpen: Bool
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color("Secondary"))
                .font(.system(size: 52, weight: .bold, design: .default))
            Spacer()
            Button {
                sidebarOpen = true
            } label: {
                Image("Hamburger")
            }
        }.padding(.bottom,20)
    }
}

struct HeaderAndNavigation_Previews: PreviewProvider {
    static var previews: some View {
        HeaderAndNavigation(sidebarOpen: .constant(false),title:"Recipes")
    }
}
