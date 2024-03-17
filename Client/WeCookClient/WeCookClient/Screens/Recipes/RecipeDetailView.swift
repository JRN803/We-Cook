//
//  RecipeDetailView.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe:Recipe
    @State var activeTab: String = "Ingredients"
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        GeometryReader { shape in
            VStack(alignment:.leading,spacing: 0) {
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: shape.size.height*0.4)
                ZStack {
                    Rectangle()
                        .fill(.white)
                        .frame(height: (shape.size.height*0.60)+15)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
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
            .overlay(Rectangle().fill(activeTab == name ? Color.primaryColor : .white).frame(height: 2).offset(y: 15))
            .onTapGesture {
                activeTab = name
            }
    }
}


struct IngredientsList: View {
    var recipe:Recipe
    var body: some View {
        List {
            ForEach(recipe.ingredients,id:\.self) {ingredient in
                HStack {
                    Image(systemName:"circle.fill")
                        .resizable()
                        .frame(width:8,height:8)
                        .foregroundStyle(Color.primaryColor)
                    Text(ingredient)
                }
            }
        }.listStyle(PlainListStyle())
    }
}


#Preview {
    RecipeDetailView(recipe: MockRecipeData.sampleRecipe)
}
