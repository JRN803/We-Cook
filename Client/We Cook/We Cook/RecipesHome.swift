//
//  RecipesHome.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/6/24.
//

import SwiftUI

struct RecipesHome: View {
    
    @StateObject var viewModel = RecipesHomeViewModel()
    
    @Binding var sidebarOpen: Bool
    
    var body: some View {
        VStack{
            HeaderAndNavigation(sidebarOpen: $sidebarOpen, title: "Recipes")
            FilterTabs(selectedFilter: $viewModel.selectedFilter)
            RecipeSearchBar(searchText:$viewModel.searchText,creatingNewRecipe: $viewModel.creatingNewRecipe)
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
            .listStyle(PlainListStyle())
            Spacer()
        }
        .navigationTitle("Recipes")
        .padding(.horizontal, 8)
        .sheet(isPresented: $viewModel.creatingNewRecipe, content: {
            NewRecipeSheet(creatingNewRecipe: $viewModel.creatingNewRecipe)
                .presentationDetents([.fraction(0.75)])
        })
    }
}

struct RecipesHome_Previews: PreviewProvider {
    static var previews: some View {
        RecipesHome(sidebarOpen: .constant(false))
            .preferredColorScheme(.dark)
    }
}
