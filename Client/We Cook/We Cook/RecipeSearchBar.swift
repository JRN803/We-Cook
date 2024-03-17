//
//  RecipeSearchBar.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/8/24.
//

import SwiftUI

struct RecipeSearchBar: View {
    @Binding var searchText: String
    @Binding var creatingNewRecipe: Bool
    var body: some View {
        HStack {
            TextField("Search for a Recipe",text:$searchText)
                .frame(maxHeight: 28)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
            
            Button {
                creatingNewRecipe = !creatingNewRecipe
            }
            label: {
                Image(systemName:"plus.app.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight:35)
                    .tint(Color("Secondary Shade"))
            }
        }
    }
}

//#Preview {
//    RecipeSearchBar(searchText: .constant(""))
//}
