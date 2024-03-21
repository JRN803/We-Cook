//
//  Alert.swift
//  Appetizers
//
//  Created by Jonathan Nguyen on 3/11/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    //Mark: - Network Alerts
    static let noUserSaved = AlertItem(title: Text("No Saved User"),
                                       message: Text("Please register or login."),
                                       dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Failed Request"),
                                                message: Text("The request to the server could not be completed"),
                                            dismissButton: .default(Text("OK")))
    
    static let emailRegistered = AlertItem(title: Text("Email Already Exists"),
                                                message: Text("The email is already associated with an account"),
                                            dismissButton: .default(Text("OK")))
    
    static let invalidURL = AlertItem(title: Text("Invalid URL"),
                                                message: Text("The request to the server failed"),
                                            dismissButton: .default(Text("OK")))
    static let invalidData = AlertItem(title: Text("Invalid Form"),
                                                message: Text("Some fields were missing."),
                                            dismissButton: .default(Text("OK")))
    static let invalidCredentials = AlertItem(title: Text("Invalid Login"),
                                                message: Text("No users found with that login."),
                                            dismissButton: .default(Text("OK")))
    
    static let accountCreated = AlertItem(title: Text("Account Created"),
                                          message: Text("Proceed Login"),
                                          dismissButton: .default(Text("OK")))
    
    static let missingField = AlertItem(title: Text("Missing Fields"),
                                        message: Text("Please fill in all the fields"),
                                        dismissButton: .default(Text("OK")))
    
    static let failedToSaveRecipe = AlertItem(title: Text("Creation Failed"),
                                        message: Text("Failed to save recipe. Please try again."),
                                        dismissButton: .default(Text("OK")))
    
    static let invalidEmail = AlertItem(title: Text("Invalid Email"),
                                        message: Text("Please enter a valid email."),
                                        dismissButton: .default(Text("OK")))
}

