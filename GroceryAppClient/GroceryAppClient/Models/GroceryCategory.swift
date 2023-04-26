//
//  GroceryCategory.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/26/23.
//

import Foundation

struct GroceryCategory: Codable {
    
    var id: UUID? = nil 
    let title: String
    let color: String
    let userId: UUID
    
}
