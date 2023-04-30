//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/28/23.
//

import Foundation
import Vapor

struct GroceryCategoryRequest: Content {
    let title: String
    let color: String
    let userId: UUID 
}
