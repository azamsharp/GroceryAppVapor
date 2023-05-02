//
//  File.swift
//  
//
//  Created by Mohammad Azam on 5/2/23.
//

import Foundation
import GroceryAppShared
import Vapor 

extension GroceryCategoryResponseDTO: Content {
    
    init?(_ groceryCategory: GroceryCategory) {
        
        guard let id = groceryCategory.id
        else {
            return nil
        }
        
        self.init(id: id, title: groceryCategory.title, color: groceryCategory.color, noOfItems: 3)
        
    }
    
}
