//
//  RecipesView.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct RecipesView: View {
    
    @StateObject var viewModel = RecipesViewModel()
    @ObservedObject var appViewModel = AppViewModel.shared
    @ObservedObject var authViewModel = AuthViewModel.shared
    var body: some View {
        NavigationStack {
            ZStack {
                
                ContainerRelativeShape()
                    .fill(Color.primaryColor)
                    .ignoresSafeArea()
                if viewModel.isLoading { LoadingView() }
                
                VStack {
                    
                    HStack {
                        Text("Recipes")
                            .foregroundStyle(.white)
                            .font(.system(size: 52, weight: .bold, design: .default))
                        Spacer()
                    }
                    
                    SearchAndCreateNew(searchText: $viewModel.searchText, creatingNewRecipe: $viewModel.creatingNewRecipe)
                    
                    FilterTabs(selectedFilter: $viewModel.selectedFilter)
                    
                    RecipeList(data: viewModel.recipes.filter {
                        ($0.meals.contains(viewModel.selectedFilter) ||
                        viewModel.selectedFilter == .All) &&
                        ($0.name.localizedCaseInsensitiveContains(viewModel.searchText) || viewModel.searchText.isEmpty)
                    }, deleteRecipe: viewModel.deleteRecipe)
                    
                    Spacer()
                }
                .padding(.horizontal, 8)
                

            }
            .navigationViewStyle(.stack)
            .navigationTitle("Recipes")
            .toolbar(.hidden)
            .sheet(isPresented: $viewModel.creatingNewRecipe, content: {
                NewRecipeSheet(creatingNewRecipe: $viewModel.creatingNewRecipe, poll: viewModel.getRecipes)
            })
        }
        .task{
            appViewModel.hideNav = false
            do {
                try await authViewModel.retrieveUser()
                try await viewModel.getRecipes()
            } catch {
                await authViewModel.logout()
                appViewModel.selectedView = .login
                print("Home page error: \(error)")
            }
            
        }
    }
}


#Preview {
    RecipesView()
}
