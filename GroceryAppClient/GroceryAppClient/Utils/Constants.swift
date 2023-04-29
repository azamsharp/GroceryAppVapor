//
//  Constants.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import Foundation

struct Constants {
    
    private static let baseUrlPath = "http://127.0.0.1:8080/api"
    
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
    }
    
    struct Messages {
        static let usernameTaken = "Username is already taken."
        static let unknownError = "Error occured. Please try again later."
        static let groceryCategoryCreationError = "Error creating grocery category."
    }
    
}
