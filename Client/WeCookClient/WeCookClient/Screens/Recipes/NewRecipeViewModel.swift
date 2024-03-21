//
//  NewRecipeViewModel.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI
import PhotosUI

@MainActor final class NewRecipeViewModel: ObservableObject {
    
    @Published var instructions = ""
    @Published var name = ""
    @Published var hours = ""
    @Published var minutes = ""
    @Published var uri: String = ""
    
    private var uiImage: UIImage?
    @Published var image: PhotosPickerItem? {
        didSet {
            Task {
                if let loaded = try? await image?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: loaded) {
                        self.uiImage = uiImage
                        selectedImage = Image(uiImage: uiImage)
                    }
                } else {
                    print("Error uploading image")
                }
            }
        }
    }
    @Published var selectedImage: Image?
    @Published var meals: [String] = []
    @Published var ingredients: [String] = []
    @Published var currentIngredient: String = ""
    @Published var alertItem: AlertItem?
    var time: String {
        if (!hours.isEmpty && !minutes.isEmpty) {return "\(hours)hr \(minutes)min"}
        else if (!hours.isEmpty) {return "\(hours)hr"}
        else if (!minutes.isEmpty) {return "\(minutes)min"}
        else {return ""}
    }
    
    func updateMeals(_ meal:RecipeFilters) {
        if meals.contains(meal.rawValue) {
            meals = meals.filter({$0 != meal.rawValue})
        } else {
            meals.append(meal.rawValue)
        }
    }
    
    func addIngredient() {
        if !currentIngredient.isEmpty {
            ingredients.append(currentIngredient)
            currentIngredient = ""
        } else {alertItem = AlertContext.missingField}
    }
    
    func deleteIngredient(at offset: IndexSet) {
        ingredients.remove(atOffsets: offset)
    }
    
    func isValid() -> Bool {
        return !name.isEmpty && !meals.isEmpty
    }
    
    func saveChanges() async throws { // Save to database
        if !isValid() {
            alertItem = AlertContext.missingField
            throw AuthAlerts.missingField
        } else {
            guard let userSession = AuthViewModel.shared.userSession else {
                throw AuthAlerts.invalidCredentials
            }
            do {
                let newRecipe = NewRecipe(name: name, meals: meals, uri: uri,
                                          instructions: instructions, ingredients: ingredients,
                                          cookie: userSession.cookie, id: userSession.id, time: time)
                let recipeId = try await NetworkManager.shared.newRecipe(newRecipe)
                if let uiImage = uiImage?.jpegData(compressionQuality: 1)?.base64EncodedString() {
                    // network call to save recipe image
                    let body = RecipeImage(imageData: uiImage, recipeId: recipeId, id: AuthViewModel.shared.user.id, cookie: AuthViewModel.shared.user.cookie)
                    try await NetworkManager.shared.setRecipeImage(to: body)
                }
            } catch {
                throw error
            }
        }
    }
    
}
