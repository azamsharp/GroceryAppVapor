//
//  UserDefaults+Extensions.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/29/23.
//

import Foundation

extension UserDefaults {
    
    var userId: UUID? {
        get {
            guard let userIdAsString = string(forKey: "userId") else {
                return nil
            }
            
            return UUID(uuidString: userIdAsString)
        }
        
        set {
            set(newValue?.uuidString, forKey: "userId")
        }
    }
    
}
