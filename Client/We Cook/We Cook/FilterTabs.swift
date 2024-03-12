//
//  FilterTabs.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/7/24.
//

import SwiftUI

struct FilterTabs: View {
        
    let tabNames: [String] = ["All","Breakfast","Brunch","Lunch","Dinner"]
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(tabNames,id:\.self) { tabName in
                    FilterTab(label: tabName)
                }
            }
        }
    }
}

struct FilterTab: View {
    let label: String
    var isSelected: Bool = false
    var body: some View {
        Button {
            print(self)
        } label: {
            Text(label)
                .padding(.horizontal,12)
                .padding(.vertical, 2)
                .font(.system(size: 22, weight: .regular, design: .default))
                .background(isSelected ? Color("Secondary Shade") : .clear)
                .foregroundColor(.white)
                .cornerRadius(360)
        }
        .padding(6)
    }
}
struct FilterTabs_Previews: PreviewProvider {
    static var previews: some View {
        FilterTabs().preferredColorScheme(.dark)
    }
}
