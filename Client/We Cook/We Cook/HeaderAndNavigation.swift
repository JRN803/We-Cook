//
//  HeaderAndNavigation.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/6/24.
//

import SwiftUI

struct HeaderAndNavigation: View {
    var body: some View {
        HStack {
            Text("Recipes")
                .foregroundColor(Color("Secondary"))
                .font(.system(size: 52, weight: .bold, design: .default))
            Spacer()
            Button {
                
            } label: {
                Image("Hamburger")
            }
        }.padding(.bottom,20)
    }
}

struct HeaderAndNavigation_Previews: PreviewProvider {
    static var previews: some View {
        HeaderAndNavigation()
    }
}
