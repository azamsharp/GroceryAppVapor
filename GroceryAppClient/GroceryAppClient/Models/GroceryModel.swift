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
            
            let postData = ["username": username, "password": password]
            let resource = try Resource(url: Constants.Urls.register, method: .post(JSONEncoder().encode(postData)), modelType: Bool.self)
            return try await httpClient.load(resource)
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
        
        let resource = Resource(url: Constants.Urls.saveGroceryCategoryByUserId(userId: userId), modelType: [GroceryCategory].self)
        
        do {
            groceryCategories = try await httpClient.load(resource)
        } catch {
           lastError = error
        }
    }
    
    func login(username: String, password: String) async throws -> Bool {
        
        // login POST data
        let loginPostData = ["username": username, "password": password]
        
        // create the resource
        let resource = try Resource(url: Constants.Urls.login, method: .post(JSONEncoder().encode(loginPostData)), modelType: LoginResponse.self)
        
        // get login response
        let loginResponse = try await httpClient.load(resource)
        
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
        
        let defaults = UserDefaults.standard
        guard let userIdString = defaults.value(forKey: "userId") as? String,
              let userId = UUID(uuidString: userIdString)
        else {
            throw NetworkError.badRequest
        }
        
        let resource = try Resource(url: Constants.Urls.saveGroceryCategoryByUserId(userId: userId), method: .post(JSONEncoder().encode(groceryCategoryRequest)), modelType: GroceryCategory.self)
        
        let newGroceryCategory = try await httpClient.load(resource)
        
        //let newGroceryCategory = try await httpClient.createGroceryCategory(groceryCategoryRequest: groceryCategoryRequest)
        // add to the grocery categories
        groceryCategories.append(newGroceryCategory)
    }
    
}
