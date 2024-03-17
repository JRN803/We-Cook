//
//  NewRecipeSheet.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/10/24.
//

import SwiftUI

struct NewRecipeSheet: View {
    @Binding var creatingNewRecipe: Bool
    @State var recipeName:String = "New Recipe"
    var body: some View {
        ScrollView {
            HStack{
                TextField(recipeName,text:$recipeName)
                    .font(.system(size: 35,weight: .bold))
                Spacer()
                Image(systemName:"x.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color("Primary"))
                    .onTapGesture {
                        creatingNewRecipe = false
                    }
            }
            Spacer()
        }
        .interactiveDismissDisabled()
        .padding(.horizontal,15)
        .padding(.vertical,10)
    }
}

//#Preview {
//    NewRecipeSheet()
//}
