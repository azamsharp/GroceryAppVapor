//
//  File.swift
//  
//
//  Created by Mohammad Azam on 5/1/23.
//

import Foundation
import Vapor

struct GroceryItemResponse: Content {
    
    let id: UUID
    let title: String
    let price: Double
    let quantity: Int
    
}

extension GroceryItemResponse {
    
    init?(_ groceryItem: GroceryItem) {
        
        guard let groceryItemId = groceryItem.id else {
            return nil
        }
        
        self.id = groceryItemId
        self.title = groceryItem.title
        self.price = groceryItem.price
        self.quantity = groceryItem.quantity
    }
    
}
