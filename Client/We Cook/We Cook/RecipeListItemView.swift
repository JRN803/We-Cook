//
//  RecipeListItemView.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/7/24.
//

import SwiftUI

struct RecipeListItemView: View {
    var recipe: Recipe
    var body: some View {
        HStack(alignment:.center,spacing:20){
            Image(recipe.image)
                .resizable()
                .frame(width:125,height: 125)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading,spacing:8) {
                Text(recipe.name)
                    .font(.system(size: 20, weight: .semibold))
                    .bold()
                Text("Cook Time: \(recipe.time)")
                    .font(.system(size: 12, weight: .light))
                ForEach(recipe.meals,id:\.self) {meal in
                    HStack{
                        
                        Image(systemName: "heart.fill")
                            .resizable()
                            .foregroundColor(Color("Primary"))
                            .frame(width:12,height:12)
                            .aspectRatio(contentMode:.fit)
                        Text("\(recipe.likes)")
                            .font(.system(size: 12, weight: .light))
                    }
                }
            }.padding(.vertical,10)
            Spacer()
        }
        .frame(maxWidth:.infinity)
        .background(Color("Secondary"))
        .cornerRadius(5)
    }
}

struct RecipeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListItemView(recipe:MockRecipeData.sampleRecipe)
    }
}
