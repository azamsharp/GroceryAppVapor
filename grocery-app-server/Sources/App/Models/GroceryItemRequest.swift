//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/30/23.
//

import Foundation
import Vapor

struct GroceryItemRequest: Content {
    let title: String
    let price: Double
    let quantity: Int 
}
