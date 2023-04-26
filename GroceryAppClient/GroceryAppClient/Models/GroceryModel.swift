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
    
    @Published var groceryCategories: [GroceryCategory] = []
    
    func register(username: String, password: String) async throws -> Bool {
        try await httpClient.register(username: username, password: password)
    }
    
    func login(username: String, password: String) async throws -> Bool {
        
        let loginResponse = try await httpClient.login(username: username, password: password)
        if !loginResponse.error && loginResponse.token != nil {
            // save the token in the user defaults
            let defaults = UserDefaults.standard
            defaults.set(loginResponse.token!, forKey: "authToken")
            return true
        } else {
            throw NetworkError.serverError("Unable to login. Check username and password.")
        }
    }
    
    func saveGroceryCategory(groceryCategory: GroceryCategory) async throws {
        
        let newGroceryCategory = try await httpClient.createGroceryCategory(groceryCategory: groceryCategory)
        // add to the grocery categories
        groceryCategories.append(newGroceryCategory)
    }
    
}
