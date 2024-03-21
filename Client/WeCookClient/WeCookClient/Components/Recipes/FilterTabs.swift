//
//  FilterTabs.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

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
//
//#Preview {
//    FilterTabs()
//}
