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
            //Add caching here    
            AsyncImage(url: URL(string: NetworkManager.recipeImageURL+recipe.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:125,height: 125)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading,spacing:8) {
                Text(recipe.name)
                    .font(.system(size: 20, weight: .semibold))
                    .bold()
                    .foregroundStyle(.gray)
                Text("Cook Time: \(recipe.time)")
                    .font(.system(size: 12, weight: .light))
                    .foregroundStyle(.gray)
                HStack{
                    
                    Image(systemName: "heart.fill")
                        .resizable()
                        .foregroundColor(Color.primaryColor)
                        .frame(width:12,height:12)
                        .aspectRatio(contentMode:.fit)
                    Text("\(recipe.likes)")
                        .font(.system(size: 12, weight: .light))
                        .foregroundStyle(.gray)
                }
            }.padding(.vertical,10)
            Spacer()
        }
        .frame(maxWidth:.infinity)
        .background(.white)
        .cornerRadius(5)
    }
}

//struct RecipeListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeListItemView(recipe:MockRecipeData.sampleRecipe)
//    }
//}
