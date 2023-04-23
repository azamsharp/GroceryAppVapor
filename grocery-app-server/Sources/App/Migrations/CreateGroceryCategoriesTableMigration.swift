//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/22/23.
//

import Foundation
import Fluent

class CreateGroceryCategoriesTableMigration: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("grocery_categories")
            .id()
            .field("title", .string, .required)
            .field("color", .string, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("grocery_categories")
            .delete()
    }
}
