//
//  NewRecipeSheet.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/10/24.
//

import SwiftUI

struct NewRecipeSheet: View {
    
    @Binding var creatingNewRecipe: Bool
    @StateObject var viewModel = NewRecipeViewModel()
    let meals = ["Breakfast","Brunch","Lunch","Dinner"]
    var body: some View {
        ScrollView {
                    TextField("Recipe Name",text:$viewModel.name)
                    TextField("Directions",text:$viewModel.directions)
                    List(selection: $viewModel.meals) {
                        ForEach(meals, id: \.self) { meal in
                            Text(meal)
                        }
                    }
//                TextField(recipeName,text:$recipeName)
//                    .font(.system(size: 35,weight: .bold))
//                Spacer()
                Image(systemName:"x.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color("Primary"))
                    .onTapGesture {
                        creatingNewRecipe = false
                    }
            Spacer()
        }
        .interactiveDismissDisabled()
        .padding(.horizontal,15)
        .padding(.vertical,10)
    }
}

#Preview {
    NewRecipeSheet(creatingNewRecipe: .constant(true))
}
