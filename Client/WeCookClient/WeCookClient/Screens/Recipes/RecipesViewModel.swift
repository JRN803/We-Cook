//
//  RecipesViewModel.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

@MainActor final class RecipesViewModel: ObservableObject {
    
    @AppStorage("userSession") private var userData: Data?
    @Published var selectedFilter = RecipeFilters.All
    @Published var searchText = ""
    @Published var creatingNewRecipe = false
    @Published var recipes: [Recipe] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    func getRecipes() async throws{
        isLoading = true
        do {
            guard let userSession = AuthViewModel.shared.userSession else {
                throw AuthAlerts.invalidCredentials
            }
            recipes = try await NetworkManager.shared.getRecipes(user: userSession)
            isLoading = false
        } catch {
            print("getRecipes Error: \(error)")
            alertItem = AlertContext.unableToComplete
            isLoading = false
            throw AuthAlerts.invalidCredentials
        }
    }
    
    func deleteRecipe(_ id: Int) async throws {
        // network call to delete recipe from database
        do {
            guard let userSession = AuthViewModel.shared.userSession else {
                throw AuthAlerts.invalidCredentials
            }
            try await NetworkManager.shared.deleteRecipe(for: userSession, id)
            try await getRecipes()
        } catch {throw error}
    }
    
}
