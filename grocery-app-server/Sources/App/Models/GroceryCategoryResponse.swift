//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/30/23.
//

import Foundation
import Vapor

struct GroceryCategoryResponse: Content {
    let id: UUID
    let title: String
    let color: String
    let userId: UUID
    let noOfItems: Int
}

extension GroceryCategoryResponse {
    
    init?(_ groceryCategory: GroceryCategory) {
        
        guard let id = groceryCategory.id
        else {
            return nil
        }
        
        self.id = id
        self.title = groceryCategory.title
        self.color = groceryCategory.color
        self.userId = groceryCategory.$user.id
        self.noOfItems = groceryCategory.items.count
    }
}


