//
//  Constants.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import Foundation

struct Constants {
    
    private static let baseUrlPath = "http://127.0.0.1:8080/api"
    
    struct Strings {
        static let authToken = "authToken"
    }
    
    struct Urls {
        static let register = URL(string: "\(baseUrlPath)/register")!
        static let login = URL(string: "\(baseUrlPath)/login")!
        
        static func saveGroceryCategoryByUserId(userId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories")!
        }
        
        static func groceryCategoriesBy(userId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories")!
        }
        
        static func deleteGroceryCategory(userId: UUID, groceryCategoryId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories/\(groceryCategoryId)")!
        }
        
        static func deleteGroceryItem(userId: UUID, groceryCategoryId: UUID, groceryItemId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items/\(groceryItemId)")!
        }
        
        static func groceryItemsBy(userId: UUID, groceryCategoryId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items")!
        }
        
        static func saveGroceryItem(userId: UUID, groceryCategoryId: UUID) -> URL {
            return URL(string: "\(baseUrlPath)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items")!
        }
    }
    
    struct Messages {
        static let usernameTaken = "Username is already taken."
        static let unknownError = "Error occured. Please try again later."
        static let groceryCategoryCreationError = "Error creating grocery category."
        static let loginError = "Unable to login. Please check username and password."
    }
    
}
