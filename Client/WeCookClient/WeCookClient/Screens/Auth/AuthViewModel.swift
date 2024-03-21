//
//  AuthViewModel.swift
//  WeCookClient
//
//  Created by Jonathan Nguyen on 3/17/24.
//

import SwiftUI
import PhotosUI

@MainActor final class AuthViewModel: ObservableObject {
    
    static let shared = AuthViewModel()
    @AppStorage("userSession") private var userData: Data?
    @Published var user = User()
    @Published var alertItem: AlertItem?
    @Published var registerSuccess = false
    @Published var loginSuccess = false
    @Published var userSession: UserSession?
    @Published var uiImage: UIImage?
    @Published var imageData: PhotosPickerItem? {
        didSet {
            Task {
                if let loaded = try? await imageData?.loadTransferable(type: Data.self) {
                    self.uiImage = UIImage(data: loaded)
                } else {
                    print("Error uploading image")
                }
            }
        }
    }
    
    func isValid() -> Bool {
        guard !user.fName.isEmpty && !user.lName.isEmpty && !user.email.isEmpty else {
            alertItem = AlertContext.missingField
            return false
        }
        
        guard user.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail
            return false
        }
        return true
        
    }
    func saveUser() async {
        guard isValid() else {return}
        do {
            if let alert = try await NetworkManager.shared.registerUser(user) {
                switch alert {
                case .emailRegistered:
                    alertItem = AlertContext.emailRegistered
                    return
                case .invalidData:
                    alertItem = AlertContext.invalidData
                    return
                default:
                    alertItem = AlertContext.unableToComplete
                    return
                }
            }
            alertItem = AlertContext.accountCreated
            registerSuccess = true
        } catch {
            alertItem = AlertContext.unableToComplete
        }
        
    }
    
    func loginUser() async throws{
        
        do {
            let data = try await NetworkManager.shared.loginUser(user)
            let encodedData = try JSONEncoder().encode(data)
            userData = encodedData
            try await retrieveUser()
        } catch AuthAlerts.invalidURL{
            alertItem = AlertContext.invalidURL
            throw AuthAlerts.invalidURL
        } catch AuthAlerts.invalidData {
            alertItem = AlertContext.invalidData
            throw AuthAlerts.invalidData
        } catch AuthAlerts.invalidCredentials {
            alertItem = AlertContext.invalidCredentials
            throw AuthAlerts.invalidCredentials
        } catch {
            print("ERROR LOGIN: \(error)")
            alertItem = AlertContext.unableToComplete
            throw AuthAlerts.unableToComplete
        }
    }
    
    func retrieveUser() async throws {
        guard let userData else { throw AuthAlerts.noUserSaved}
        do {
            userSession = try JSONDecoder().decode(UserSession.self, from: userData)
            if let userSession {
                user.fName = userSession.fName
                user.lName = userSession.lName
                user.id = userSession.id
                user.cookie = userSession.cookie
                user.bio = userSession.bio
                user.email = userSession.email
                user.pfp = userSession.pfp
            }
            
        } catch {
            throw AuthAlerts.invalidData
        }
    }
    
    func logout() async{
        
        guard let userSession else {
             return
        }
        
        do {
            try await NetworkManager.shared.logout(user: userSession)
            userData = nil
        } catch AuthAlerts.invalidData {
            return
        } catch {
            return
        }
    }
    
    func saveChanges() async throws {
        do {
            let data = try await NetworkManager.shared.updateUserInfo(to: user)
            let encodedData = try JSONEncoder().encode(data)
            userData = encodedData
            try await retrieveUser()
            if let uiImage = uiImage?.jpegData(compressionQuality: 1)?.base64EncodedString() {
                // network call to save recipe image
                let body = UserImage(imageData: uiImage, id: user.id, cookie: user.cookie)
                try await NetworkManager.shared.setUserImage(to: body)
            }
        } catch {
            uiImage = nil
            print("Error saving profile changes: \(error)")
        }
    }
    
}
