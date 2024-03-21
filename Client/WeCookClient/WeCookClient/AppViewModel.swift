//
//  AppViewModel.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/18/24.
//

import SwiftUI

final class AppViewModel: ObservableObject {
    
    static let shared = AppViewModel()
    
    @Published var selectedView: Views = .recipes
    @Published var hideNav: Bool = false
    @Published var sidebarOpen: Bool = false
    
}
