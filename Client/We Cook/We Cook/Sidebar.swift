//
//  Sidebar.swift
//  We Cook
//
//  Created by Jonathan Nguyen on 3/16/24.
//

import SwiftUI

struct Sidebar: View {
    
    @Binding var sidebarOpen: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.6))
            .opacity(sidebarOpen ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: sidebarOpen)
            .onTapGesture {
                sidebarOpen.toggle()
            }
            HStack(alignment: .top) {
                Spacer()
                ZStack(alignment: .top) {
                    Color(.white)
                    VStack {
                    }
                }
                .frame(width: UIScreen.main.bounds.size.width)
                .offset(x: sidebarOpen ? UIScreen.main.bounds.size.width*(0.3) : UIScreen.main.bounds.size.width)
                .animation(.default.speed(1), value: sidebarOpen)
            }
        }
        .ignoresSafeArea()
    }
}
//
//#Preview {
//    Sidebar()
//}
