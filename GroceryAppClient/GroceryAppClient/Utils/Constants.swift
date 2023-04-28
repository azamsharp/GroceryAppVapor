//
//  Constants.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let register = URL(string: "http://127.0.0.1:8080/api/register")!
        static let login = URL(string: "http://127.0.0.1:8080/api/login")!
        
        static func saveGroceryCategoryByUserId(userId: UUID) -> URL {
            return URL(string: "http://127.0.0.1:8080/api/users/\(userId)/grocery-categories")!
        }
        
        static func groceryCategoriesByUserId(userId: UUID) -> URL {
            return URL(string: "http://127.0.0.1:8080/api/users/\(userId)/grocery-categories")!
        }
    }
    
    struct Messages {
        static let usernameTaken = "Username is already taken."
        static let unknownError = "Error occured. Please try again later."
        static let groceryCategoryCreationError = "Error creating grocery category."
    }
    
}
