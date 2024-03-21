//
//  User.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/17/24.
//

import SwiftUI

struct User: Codable {
    var email: String = ""
    var password: String = ""
    var remember: Bool = false
    var fName: String = ""
    var lName: String = ""
    var id: Int = -1
    var cookie: String = ""
    var bio: String = ""
    var pfp: String = ""
    
}

struct UserImage: Codable {
    let imageData: String
    let id: Int
    let cookie: String
}
