//
//  FilterTabs.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/7/24.
//

import SwiftUI

struct FilterTabs: View {
    
    @Binding var selectedFilter: String
    
    let tabNames: [String] = ["All","Breakfast","Brunch","Lunch","Dinner"]
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(tabNames,id:\.self) { tabName in
                    FilterTab(label: tabName,isSelected: selectedFilter == tabName)
                        .onTapGesture {
                            selectedFilter = tabName
                        }
                }
            }
        }
    }
}

struct FilterTab: View {
    let label: String
    let isSelected: Bool
    var body: some View {
        Text(label)
            .padding(.horizontal,12)
            .padding(.vertical, 2)
            .font(.system(size: 22, weight: .regular, design: .default))
            .background(isSelected ? Color("Secondary Shade") : .clear)
            .foregroundColor(isSelected ? Color("Primary") : .white)
            .cornerRadius(360)
            .padding(6)
    }
}
//struct FilterTabs_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterTabs().preferredColorScheme(.dark)
//    }
//}
