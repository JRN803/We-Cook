//
//  NetworkManager.swift
//  Appetizers
//
//  Created by Jonathan Nguyen on 3/11/24.
//

import UIKit
import SwiftUI

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let baseURL = "http://192.168.1.182:8080/api"
    private let registerURL = baseURL + "/user/register"
    private let loginURL = baseURL + "/user/login"
    private let homeURL = baseURL + "/user/home"
    private let logoutURL = baseURL + "/user/logout"
    private let newRecipeURL = baseURL + "/user/home/newrecipe"
    private let deleteRecipeURL = baseURL + "/user/home/deleterecipe?"
    static let userImageURL = baseURL + "/images/pfp?id="
    static let recipeImageURL = baseURL + "/images/recipe?name="
    static let editUserURL = baseURL + "/user/edit"

    private let cache = NSCache<NSString,UIImage>()
    
    private init() {}
    
    func registerUser(_ user:User) async throws -> AuthAlerts? {
        guard let url = URL(string: registerURL) else {
            return AuthAlerts.invalidURL
        }
        
        guard let encodedData = try? JSONEncoder().encode(user) else {
            return AuthAlerts.unableToComplete
        }
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let (_, response) = try await URLSession.shared.upload(for: request,from:encodedData)
            guard let response = response as? HTTPURLResponse else {return AuthAlerts.invalidData}
            switch response.statusCode {
            case 400:
                return AuthAlerts.emailRegistered
            case 401:
                return AuthAlerts.invalidData
            default:
                return nil
            }
        } catch {
            return AuthAlerts.invalidData
        }
        
    }
    
    func logout (user:UserSession) async throws {
        
        guard let url = URL(string: logoutURL) else {
            throw AuthAlerts.invalidURL
        }
        
        guard let encodedData = try? JSONEncoder().encode(user) else {
            throw AuthAlerts.unableToComplete
        }
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let (_, response) = try await URLSession.shared.upload(for: request,from:encodedData)
        if let response = response as? HTTPURLResponse,response.statusCode != 200 {
            switch response.statusCode {
            case 401:
                throw AuthAlerts.invalidData
            default:
                throw AuthAlerts.unableToComplete
            }
        }

    }
    
    func loginUser(_ user:User) async throws -> UserSession {
        guard let url = URL(string: loginURL) else {
            throw AuthAlerts.invalidURL
        }
        
        guard let encodedData = try? JSONEncoder().encode(user) else {
            throw AuthAlerts.unableToComplete
        }
        
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let (data, response) = try await URLSession.shared.upload(for: request,from:encodedData)
        if let response = response as? HTTPURLResponse,response.statusCode != 200 {

            switch response.statusCode {
            case 403:
                throw AuthAlerts.invalidCredentials
            case 401:
                throw AuthAlerts.invalidData
            default:
                throw AuthAlerts.unableToComplete
            }
        }
        let decoded = try JSONDecoder().decode(UserSession.self, from: data)
        return decoded

        
    }
    
    func getRecipes(user: UserSession) async throws -> [Recipe] {
        
        guard let url = URL(string: homeURL) else {
            throw AuthAlerts.invalidURL
        }
        guard let encodedData = try? JSONEncoder().encode(user) else {
            throw AuthAlerts.unableToComplete
        }
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let (data, response) = try await URLSession.shared.upload(for: request,from:encodedData)
        let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
        guard let response = response as? HTTPURLResponse else {throw AuthAlerts.invalidData}
        switch response.statusCode {
        case 403:
            throw AuthAlerts.invalidCredentials
        case 401:
            throw AuthAlerts.invalidData
        default:
            return decoded.Recipes
        }

        
    }
    
    func newRecipe(_ recipe: NewRecipe) async throws -> Int {
        guard let url = URL(string: newRecipeURL) else {
            throw AuthAlerts.invalidURL
        }
        guard let encodedData = try? JSONEncoder().encode(recipe) else {
            throw AuthAlerts.invalidData
        }
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let (data, response) = try await URLSession.shared.upload(for: request,from:encodedData)
        if let response = response as? HTTPURLResponse, response.statusCode != 201  {throw AuthAlerts.invalidData}
        let decoded = try JSONDecoder().decode(NewRecipeResponse.self, from: data)
        return decoded.id
    }
    
    func deleteRecipe(for userSession: UserSession, _ id: Int) async throws {
        guard let url = URL(string: "\(deleteRecipeURL)id=\(id)") else {
            throw AuthAlerts.invalidURL
        }
        guard let encodedData = try? JSONEncoder().encode(userSession) else {
            throw AuthAlerts.unableToComplete
        }
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let (_, response) = try await URLSession.shared.upload(for: request,from:encodedData)
        if let response = response as? HTTPURLResponse, response.statusCode != 200  {throw AuthAlerts.invalidData}
    }
    
    func setRecipeImage(to recipe: RecipeImage) async throws {
        guard let url = URL(string: NetworkManager.recipeImageURL) else {
            throw AuthAlerts.invalidURL
        }
        guard let encodedData = try? JSONEncoder().encode(recipe) else {
            throw AuthAlerts.invalidData
        }
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let (_, response) = try await URLSession.shared.upload(for: request,from:encodedData)
        if let response = response as? HTTPURLResponse, response.statusCode != 201 {throw AuthAlerts.unableToComplete}
        
    }
    
    func setUserImage(to image: UserImage) async throws {
        guard let url = URL(string: NetworkManager.userImageURL) else {
            throw AuthAlerts.invalidURL
        }
        guard let encodedData = try? JSONEncoder().encode(image) else {
            throw AuthAlerts.invalidData
        }
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let (_, response) = try await URLSession.shared.upload(for: request,from:encodedData)
        if let response = response as? HTTPURLResponse, response.statusCode != 201 {throw AuthAlerts.unableToComplete}
        
    }
    
    func updateUserInfo(to user: User) async throws -> UserSession {
        guard let url = URL(string: NetworkManager.editUserURL) else {
            throw AuthAlerts.invalidURL
        }
        guard let encodedData = try? JSONEncoder().encode(user) else {
            throw AuthAlerts.invalidData
        }
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let (data, response) = try await URLSession.shared.upload(for: request,from:encodedData)
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {throw AuthAlerts.unableToComplete}
        let decoded = try JSONDecoder().decode(UserSession.self, from: data)
        return decoded
    }
    
// ADD CACHING FOR IMAGES
    
//    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void){
//        let cacheKey = NSString(string: urlString)
//        if let image = cache.object(forKey: cacheKey) {
//            completed(image)
//            return
//        }
//        guard let url = URL(string: urlString) else {
//            completed(nil)
//            return
//        }
//        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, response, error in
//            guard let data = data, let image = UIImage(data: data) else {
//                completed(nil)
//                return
//            }
//            self.cache.setObject(image, forKey: cacheKey)
//            completed(image)
//        }
//        task.resume()
//
//    }
}
