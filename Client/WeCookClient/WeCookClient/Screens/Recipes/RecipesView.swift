//
//  RecipesView.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct RecipesView: View {
    
   @StateObject var viewModel = RecipesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ContainerRelativeShape()
                    .fill(Color.primaryColor)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Recipes")
                            .foregroundStyle(.white)
                            .font(.system(size: 52, weight: .bold, design: .default))
                        Spacer()
                    }
                    FilterTabs(selectedFilter: $viewModel.selectedFilter)
                    Spacer()
                }
                
                .padding(.horizontal, 8)
            }
        }
    }
}

struct FilterTabs: View {
    @Binding var selectedFilter: RecipeFilters
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(RecipeFilters.allCases, id: \.rawValue) {filter in
                    Text("\(filter)")
                        .padding(.horizontal,12)
                        .padding(.vertical, 2)
                        .font(.system(size: 22, weight: .regular, design: .default))
                        .background(filter == selectedFilter ? Color.secondaryWhite : .clear)
                        .foregroundColor(filter == selectedFilter ? Color.primaryColor : .white)
                        .cornerRadius(360)
                        .padding(6)
                        .onTapGesture {selectedFilter = filter}
                }
            }
        }
    }
    
}

#Preview {
    RecipesView()
}
