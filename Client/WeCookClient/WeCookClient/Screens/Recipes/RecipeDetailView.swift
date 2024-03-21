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
    
    var deleteRecipe: (Int) async throws -> Void
    var body: some View {
        GeometryReader { shape in
            VStack(alignment:.leading,spacing: 0) {
                AsyncImage(url: URL(string: NetworkManager.recipeImageURL+recipe.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: shape.size.height*0.4)
                } placeholder: {
                    Image("defaultRecipe")
                        .resizable()
                        .scaledToFill()
                        .frame(height: shape.size.height*0.4)
                }
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
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom,1)
                        HStack{
                            Text("Estimated Cook Time: \(recipe.time)")
                                .font(.system(size: 18,weight: .light))
                                .foregroundStyle(.gray)
                            Spacer()
                        }                        
                        .padding(.horizontal, 25)

                        HStack{
                            Link("Reference Link", destination: URL(string: recipe.uri)!)
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
                                    Text(recipe.instructions).lineSpacing(10.0)
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                                .padding(.horizontal,25)
                                .padding(.top,15)
                                .padding(.bottom,50)
                            }
                        default:

                            Text("Delete this")
                                .foregroundStyle(.black)
                                .onTapGesture {
                                    Task {
                                        do {
                                            try await deleteRecipe(recipe.id)
                                            dismiss()
                                        } catch { print("error in recipe detail view delete: \(error)")}
                                    }
                                }
                        }
                        
                        Spacer()
                    }
                }
            }
        }
        .onAppear{AppViewModel.shared.hideNav = true}
        .onDisappear{AppViewModel.shared.hideNav = false}
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
            .foregroundStyle(.black)

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
                        .foregroundStyle(.black)
                }
            }
            .listRowBackground(Color.white)
        }
        .listStyle(PlainListStyle())
    }
}

//
//#Preview {
//    RecipeDetailView(recipe: MockRecipeData.sampleRecipe)
//}
