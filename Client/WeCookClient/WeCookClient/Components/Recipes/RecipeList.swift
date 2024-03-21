//
//  RecipeList.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct RecipeList: View {
    var data: [Recipe]
    var deleteRecipe: (Int) async throws -> Void
    var body: some View {
        
        if data.isEmpty {
            EmptyRecipes()
        }
        
        List {
            
            ForEach(data) { recipe in
                
                ZStack{
                    NavigationLink(destination: RecipeDetailView(recipe: recipe,deleteRecipe: deleteRecipe)) {
                    }
                    .opacity(0)
                    RecipeListItemView(recipe: recipe)
                }
                .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .listRowBackground(Color(.clear))
                .listRowSeparator(.hidden)
                
                
            }
            
        }
        .listStyle(PlainListStyle())
    }
    
}

//#Preview {
//    RecipeList()
//}
