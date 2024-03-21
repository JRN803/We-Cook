//
//  NewRecipeViewModel.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

final class NewRecipeViewModel: ObservableObject {
    
//    @AppStorage("user") private var userData: Data?
    
    @Published var ingredients = Set<String>()
    @Published var name = ""
    @Published var meals = Set<String>()
    @Published var directions: String = ""
    @Published var uri: String = ""
    
    
    
}
