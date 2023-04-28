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
    @Published var groceryCategories: [GroceryCategory] = []
    
    func register(username: String, password: String) async -> Bool {
        do {
            return try await httpClient.register(username: username, password: password)
        } catch {
            lastError = error
        }
        
        return false
    }
    
    func populateGroceryCategories() async {
                
        let defaults = UserDefaults.standard
        guard let userIdString = defaults.value(forKey: "userId") as? String,
              let userId = UUID(uuidString: userIdString)
        else {
            return
        }
        
        do {
            groceryCategories = try await httpClient.getGroceryCategoriesBy(userId: userId)
        } catch {
            lastError = error 
        }
    }
    
    func login(username: String, password: String) async throws -> Bool {
        
        let loginResponse = try await httpClient.login(username: username, password: password)
        if !loginResponse.error && loginResponse.token != nil {
            // save the token in the user defaults
            let defaults = UserDefaults.standard
            defaults.set(loginResponse.token!, forKey: "authToken")
            defaults.set(loginResponse.userId.uuidString, forKey: "userId")
            return true
        } else {
            throw NetworkError.serverError("Unable to login. Check username and password.")
        }
    }
    
    func saveGroceryCategory(groceryCategoryRequest: GroceryCategoryRequest) async throws {
        
        let newGroceryCategory = try await httpClient.createGroceryCategory(groceryCategoryRequest: groceryCategoryRequest)
        // add to the grocery categories
        groceryCategories.append(newGroceryCategory)
    }
    
}
