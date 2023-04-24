//
//  GroceryModel.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import Foundation

@MainActor
class GroceryModel: ObservableObject {
    
    let httpClient = HTTPClient()
    
    @Published var lastError: Error?
    
    func register(username: String, password: String) async -> Bool {
        
        do {
            let registrationResponse = try await httpClient.register(username: username, password: password)
            if registrationResponse.error {
                lastError = NetworkError.serverError(registrationResponse.reason ?? "")
                return false
            }
        } catch {
            lastError = error
            return false
        }
        
        return true
    }
    
    func login(username: String, password: String) async throws -> LoginResponse {
        return try await httpClient.login(username: username, password: password)
    }
    
}
