//
//  SearchAndCreateNew.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct SearchAndCreateNew: View {
    @Binding var searchText: String
    @Binding var creatingNewRecipe: Bool
    
    var body: some View {
        HStack {
            TextField("Search for a Recipe",text:$searchText)
                .frame(maxHeight: 28)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .foregroundStyle(.gray)
                .background(.white)
                .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white, lineWidth: 2)
                    )
            Button {
                creatingNewRecipe = !creatingNewRecipe
            }
            label: {
                Image(systemName:"plus.app.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight:35)
                    .tint(Color.secondaryWhite)
            }
        }
    }
}
//
//#Preview {
//    SearchAndCreateNew()
//}
