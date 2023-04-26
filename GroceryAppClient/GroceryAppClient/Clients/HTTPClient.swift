//
//  HTTPClient.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case serverError(String)
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString("Unable to perform request", comment: "badRequestError")
            case .serverError(let errorMessage):
                print(errorMessage)
                return NSLocalizedString(errorMessage, comment: "serverError")
        }
    }
    
}

struct HTTPClient {
    
    func register(username: String, password: String) async throws -> Bool {
        
        let registerBody = ["username": username, "password": password]
        
        var request = URLRequest(url: Constants.Urls.register)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(registerBody)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badRequest
        }
        
        switch httpResponse.statusCode {
            case 200...201:
                return true
            case 409:
                throw NetworkError.serverError(Constants.Messages.usernameTaken)
            default:
                throw NetworkError.serverError(Constants.Messages.unknownError)
        }
    }
    
    func login(username: String, password: String) async throws -> LoginResponse {
        
        let loginBody = ["username": username, "password": password]
        
        var request = URLRequest(url: Constants.Urls.login)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(loginBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let _ = response as? HTTPURLResponse else {
            throw NetworkError.badRequest
        }
        
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        return loginResponse
    }
    
    func createGroceryCategory(groceryCategory: GroceryCategory) async throws -> GroceryCategory {
        
        var request = URLRequest(url: Constants.Urls.saveGroceryCategory)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(groceryCategory)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.badRequest
        }
        
        switch httpResponse.statusCode {
            case 200...201:
                let savedGroceryCategory = try JSONDecoder().decode(GroceryCategory.self, from: data)
                return savedGroceryCategory
            case 409:
                throw NetworkError.serverError(Constants.Messages.groceryCategoryCreationError)
            default:
                throw NetworkError.serverError(Constants.Messages.unknownError)
        }
        
    }
    
}
