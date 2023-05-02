//
//  GroceryCategoryResponseDTO+Extensions.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 5/2/23.
//

import Foundation
import GroceryAppShared
import SwiftUI


extension GroceryCategoryResponseDTO: Identifiable, Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: GroceryCategoryResponseDTO, rhs: GroceryCategoryResponseDTO) -> Bool {
        return lhs.id == rhs.id 
    }
    
    
}
