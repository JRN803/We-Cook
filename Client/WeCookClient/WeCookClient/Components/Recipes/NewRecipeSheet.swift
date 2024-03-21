//
//  NewRecipeSheet.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI
import PhotosUI

struct NewRecipeSheet: View {
    @Binding var creatingNewRecipe: Bool
    var poll: () async throws -> Void
    @StateObject var viewModel = NewRecipeViewModel()
    
    var body: some View {
        Form {
            Section("Recipe Details") {
                
                TextField("Recipe Name", text: $viewModel.name)
                TextField("Directions", text: $viewModel.instructions,axis: .vertical)
                TextField("Reference Link", text: $viewModel.uri)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                HStack {
                    TextField("Hours",text:$viewModel.hours)
                        .keyboardType(.numberPad)
                    TextField("Minutes",text:$viewModel.minutes)
                        .keyboardType(.numberPad)
                }
                
            }
            Section("Category") {
                ForEach(RecipeFilters.allCases[1...],id: \.rawValue) {meal in
                    HStack {
                        Image(systemName: !viewModel.meals.contains(meal.rawValue) ? "circle" : "checkmark.circle.fill")
                            .foregroundStyle(Color.primaryColor)
                            .frame(width:15)
                        Text("\(meal)")

                    }
                    .onTapGesture {
                        viewModel.updateMeals(meal)
                    }
                }
            }
            Section("Ingredients") {
                HStack {
                    TextField("Add Ingredient",text: $viewModel.currentIngredient)
                    Button {
                        viewModel.addIngredient()
                    }label: {
                        Image(systemName: "plus")
                    }
                }
                ForEach(viewModel.ingredients, id: \.self) {ingredient in
                    Text(ingredient)
                }.onDelete(perform: viewModel.deleteIngredient)
            }
            Section("Image") {
                PhotosPicker("Upload Image",selection: $viewModel.image, matching: .images)
                viewModel.selectedImage?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                Button {
                    Task {
                        do{
                            try await viewModel.saveChanges()
                            try await poll()
                            creatingNewRecipe = false
                        } catch {
                            print("Error new recipe: \(error)")
                            viewModel.alertItem = AlertContext.failedToSaveRecipe
                        }
                    }
                } label: {
                    Text("Save Recipe")
                }
            }
        }
        .alert(item: $viewModel.alertItem) {alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        .overlay(
            Button {
                creatingNewRecipe = false
            } label: {
                Image(systemName:"xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15)
                    .foregroundStyle(Color.primaryColor)
                    .padding()
            },
            alignment: .topTrailing
        )
    }
}

//#Preview {
//    NewRecipeSheet(creatingNewRecipe: .constant(false))
//}
