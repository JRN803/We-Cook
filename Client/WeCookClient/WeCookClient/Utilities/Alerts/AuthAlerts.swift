//
//  AuthErrors.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/17/24.
//

import Foundation

enum AuthAlerts: Error {
    case noUserSaved, invalidData,
         unableToComplete, invalidURL,
         emailRegistered, invalidCredentials,
         accountCreated, missingField, failedToSaveRecipe
}
