//
//  EmptyRecipes.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct EmptyRecipes: View {
    var body: some View {
        VStack {
            Image(systemName: "book.pages.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .foregroundStyle(Color.secondaryWhite)
                .padding()
            
            Text("No Recipes to Show")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }.padding()
    }
}

#Preview {
    EmptyRecipes()
}
