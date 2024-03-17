//
//  RecipeDetailView.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/7/24.
//

import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    @State var activeTab: String = "Ingredients"
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment:.leading,spacing: 0) {
                Image(recipe.image)
                    .resizable()
                    .aspectRatio(contentMode:.fill)
                    .frame(height: proxy.size.height * 0.40)
                
                ZStack{
                    Rectangle()
                        .fill(.white)
                        .frame(height: (proxy.size.height*0.60)+15)
                        .cornerRadius(20)
                        .offset(x:0,y:-15)
                    VStack {
                        HStack{
                            Text("\(recipe.name)")
                                .font(.system(size: 35,weight: .bold))
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom,1)
                        HStack{
                            Text("Estimated Cook Time: \(recipe.time)")
                                .font(.system(size: 18,weight: .light))
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                        HStack(spacing: 58) {
                            RecipeDetailSectionTab(name: "Ingredients", activeTab: $activeTab)
                            RecipeDetailSectionTab(name: "Directions", activeTab: $activeTab)
                            RecipeDetailSectionTab(name: "Edit", activeTab: $activeTab)
                            Spacer()
                        }
                        .padding(.leading,25)
                        .padding(.vertical,10)
                        
                        switch activeTab {
                        case "Ingredients":
                            IngredientsList(recipe: recipe)
                                .padding(.bottom,50)
                        case "Directions":
                            ScrollView{
                                HStack{
                                    Text(recipe.directions).lineSpacing(10.0)
                                    Spacer()
                                }
                                .padding(.horizontal,25)
                                .padding(.top,15)
                                .padding(.bottom,50)
                            }
                        default:
                            Text("Implement Later")
                        }
                        
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                        Text("Back to Recipes")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}


struct RecipeDetailSectionTab:View {
    let name: String
    @Binding var activeTab: String
    var body: some View {
        Text(name)
            .font(.system(size:16))
            .overlay(Rectangle().fill(activeTab == name ? Color("Primary") : .white).frame(height: 2).offset(y: 15))
            .onTapGesture {
                activeTab = name
            }
    }
}
struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe:MockRecipeData.sampleRecipe)
    }
}
