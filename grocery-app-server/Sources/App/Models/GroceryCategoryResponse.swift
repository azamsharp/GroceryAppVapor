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
}

extension GroceryCategoryResponse {
    
    init?(groceryCategory: GroceryCategory) {
        
        guard let id = groceryCategory.id
        else {
            return nil
        }
        
        self.id = id
        self.title = groceryCategory.title
        self.color = groceryCategory.color
    }
}

