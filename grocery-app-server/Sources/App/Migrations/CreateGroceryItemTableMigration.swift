//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/30/23.
//

import Foundation

import Foundation
import Fluent

class CreateGroceryItemTableMigration: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("grocery_items")
            .id()
            .field("title", .string, .required)
            .field("price", .double, .required)
            .field("quantity", .double, .required)
            .field("grocery_category_id", .uuid, .required, .references("grocery_categories", "id"))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("grocery_items")
            .delete()
    }
}