//
//  GroceryCategory.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/26/23.
//

import Foundation

struct GroceryCategory: Codable {
    
    let id: UUID?
    let title: String
    let colorCode: String
    let userId: UUID
    
}
