//
//  LoginResponse.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/17/24.
//


import SwiftUI

struct UserSession: Codable {
    var Message: String
    var cookie: String
    var id: Int
    var fName: String
    var lName: String
    var bio: String
    var email: String
    var pfp: String
}
