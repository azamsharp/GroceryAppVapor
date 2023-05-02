//
//  GroceryModel.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import Foundation
import GroceryAppShared

@MainActor
class GroceryModel: ObservableObject {
    
    let httpClient = HTTPClient()
   
    @Published var lastError: Error? 
    //@Published var groceryCategories: [GroceryCategory] = []
    @Published var groceryItems: [GroceryItem] = []
    
    @Published var groceryCategories: [GroceryCategoryResponseDTO] = []
    
    @Published var groceryCategory: GroceryCategory? 
    
    func register(username: String, password: String) async throws -> Bool {
 
        let postData = ["username": username, "password": password]
        let resource = try Resource(url: Constants.Urls.register, method: .post(JSONEncoder().encode(postData)), modelType: Bool.self)
        return try await httpClient.load(resource)
    }
    
    func logout() {
        // delete the username and token from
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "userId")
        defaults.removeObject(forKey: Constants.Strings.authToken)
    }
    
    func populateGroceryCategories() async {
                
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        
        let resource = Resource(url: Constants.Urls.groceryCategoriesBy(userId: userId), modelType: [GroceryCategoryResponseDTO].self)
        
        do {
            groceryCategories = try await httpClient.load(resource)
        } catch {
           lastError = error
        }
    }
    
    func populateGroceryItemsBy(groceryCategoryId: UUID) async {
        
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        
        let resource = Resource(url: Constants.Urls.groceryItemsBy(userId: userId, groceryCategoryId: groceryCategoryId), modelType: [GroceryItem].self)
        print(resource.url)
        do {
            groceryItems = try await httpClient.load(resource)
        } catch {
            print(error)
        }
        
    }
    
    func deleteGroceryCategory(groceryCategoryId: UUID) async throws {
        
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        
        let resource = Resource(url: Constants.Urls.deleteGroceryCategory(userId: userId, groceryCategoryId: groceryCategoryId), method: .delete, modelType: GroceryCategoryResponseDTO.self)
        
        let groceryCategory: GroceryCategoryResponseDTO = try await httpClient.load(resource)
        
        
        // remove the grocery category from the list
        //groceryCategories = groceryCategories.filter { $0.id != groceryCategory.id }
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
            defaults.set(loginResponse.token!, forKey: Constants.Strings.authToken)
            defaults.set(loginResponse.userId.uuidString, forKey: "userId")
            return true
        } else {
            throw NetworkError.serverError("Unable to login. Check username and password.")
        }
    }
    
    func saveGroceryCategory(_ groceryCategoryRequestDTO: GroceryCategoryRequestDTO) async throws {
        
        guard let userId = UserDefaults.standard.userId else {
            throw NetworkError.badRequest
        }
       
        let resource = try Resource(url: Constants.Urls.saveGroceryCategoryByUserId(userId: userId), method: .post(JSONEncoder().encode(groceryCategoryRequestDTO)), modelType: GroceryCategoryResponseDTO.self)
        
        let newGroceryCategory = try await httpClient.load(resource)
        groceryCategories.append(newGroceryCategory)
    }
    
    
    func saveGroceryItem(groceryItem: GroceryItem, groceryCategoryId: UUID) async throws {
        
        guard let userId = UserDefaults.standard.userId else {
            throw NetworkError.badRequest
        }
        
        let resource = try Resource(url: Constants.Urls.saveGroceryItem(userId: userId, groceryCategoryId: groceryCategoryId), method: .post(JSONEncoder().encode(groceryItem)), modelType: GroceryItem.self)
        
        let newGroceryItem = try await httpClient.load(resource)
        groceryItems.append(newGroceryItem)
        
    }
}
