//
//  RecipesHome.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/6/24.
//

import SwiftUI

struct RecipesHome: View {
    @State var selectedFilter: String = "All"
    @State var searchText: String = ""
    @State var creatingNewRecipe: Bool = false
    var body: some View {
        VStack{
            HeaderAndNavigation()
            FilterTabs(selectedFilter: $selectedFilter)
            RecipeSearchBar(searchText:$searchText,creatingNewRecipe: $creatingNewRecipe)
            List {
                
                ForEach(MockRecipeData.recipes) { recipe in
                    
                    ZStack{
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        }
                        .opacity(0)
                        .navigationBarTitleDisplayMode(.inline)
                        RecipeListItemView(recipe: recipe)
                    }
                    .listRowInsets(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    .listRowBackground(Color(.clear))
                    .listRowSeparator(.hidden)

                }
                
            }
            .navigationTitle("Recipes")
            .listStyle(PlainListStyle())
            Spacer()
        }
        .padding(.horizontal, 8)
        .sheet(isPresented: $creatingNewRecipe, content: {
            NewRecipeSheet(creatingNewRecipe: $creatingNewRecipe)
                .presentationDetents([.fraction(0.75)])
        })
    }
}

struct RecipesHome_Previews: PreviewProvider {
    static var previews: some View {
        RecipesHome()
            .preferredColorScheme(.dark)
    }
}
