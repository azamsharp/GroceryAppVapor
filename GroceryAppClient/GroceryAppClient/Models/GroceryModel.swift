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
    
    func register(username: String, password: String) async throws -> RegistrationResponse {
        return try await httpClient.register(username: username, password: password)
    }
    
}
