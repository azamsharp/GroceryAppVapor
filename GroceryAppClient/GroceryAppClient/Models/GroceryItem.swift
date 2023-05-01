//
//  GroceryItem.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 5/1/23.
//

import Foundation

struct GroceryItem: Codable, Identifiable {
    var id: UUID? = nil 
    let title: String
    let price: Double
    let quantity: Int
}
