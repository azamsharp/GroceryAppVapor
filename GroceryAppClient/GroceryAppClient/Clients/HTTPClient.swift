//
//  HTTPClient.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import Foundation

enum RegistrationError: Error {
    case usernameTaken
}

enum NetworkError: Error {
    case badRequest
    case invalidStatusCode(Int)
}

struct HTTPClient {
    
    func register(username: String, password: String) async throws -> RegistrationResponse {
        
        let registerRequest = ["username": username, "password": password]
        
        var request = URLRequest(url: Constants.Urls.registerUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(registerRequest)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let _ = response as? HTTPURLResponse else {
            throw NetworkError.badRequest
        }
        
        let registrationResponse = try JSONDecoder().decode(RegistrationResponse.self, from: data)
        return registrationResponse
    }
    
}
