//
//  RecipesHome.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/6/24.
//

import SwiftUI

struct RecipesHome: View {
    var body: some View {
        VStack{
            HeaderAndNavigation()
            FilterTabs()
            Spacer()
        }.padding(.horizontal, 8)
    }
}

struct RecipesHome_Previews: PreviewProvider {
    static var previews: some View {
        RecipesHome().preferredColorScheme(.dark)
    }
}
