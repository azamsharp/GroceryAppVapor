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
    
    func register(username: String, password: String) async throws -> Bool {        
        try await httpClient.register(username: username, password: password)
    }
    
    func login(username: String, password: String) async throws -> LoginResponse {
        return try await httpClient.login(username: username, password: password)
    }
    
}
