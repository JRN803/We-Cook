//
//  RecipesHomeViewModel.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

final class RecipesHomeViewModel: ObservableObject {
    @Published var selectedFilter: String = "All"
    @Published var searchText: String = ""
    @Published var creatingNewRecipe: Bool = false
}
