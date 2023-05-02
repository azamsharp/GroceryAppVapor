//
//  File.swift
//  
//
//  Created by Mohammad Azam on 5/2/23.
//

import Foundation
import Vapor
import GroceryAppShared

extension GroceryItemResponseDTO: Content {
    
    init?(_ groceryItem: GroceryItem) {
        
        guard let groceryItemId = groceryItem.id else {
            return nil
        }
        
        self.init(id: groceryItemId, title: groceryItem.title, price: groceryItem.price, quantity: groceryItem.quantity)
    }
    
}
