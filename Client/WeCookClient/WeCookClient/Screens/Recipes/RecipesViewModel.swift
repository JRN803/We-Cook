//
//  RecipesViewModel.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

final class RecipesViewModel: ObservableObject {
    
    @Published var selectedFilter = RecipeFilters.All

}
