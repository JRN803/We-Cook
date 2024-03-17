//
//  IngredientsList.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/9/24.
//

import SwiftUI

struct IngredientsList: View {
    var recipe:Recipe
    var body: some View {
        List {
            ForEach(recipe.ingredients,id:\.self) {ingredient in
                HStack {
                    Image(systemName:"circle.fill")
                        .resizable()
                        .frame(width:8,height:8)
                        .foregroundStyle(Color("Primary"))
                    Text(ingredient)
                }
            }
        }.listStyle(PlainListStyle())
    }
}

//#Preview {
//    IngredientsList()
//}
