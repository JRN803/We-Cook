//
//  NewRecipeSheet.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct NewRecipeSheet: View {
    @Binding var creatingNewRecipe: Bool
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NewRecipeSheet(creatingNewRecipe: .constant(false))
}
