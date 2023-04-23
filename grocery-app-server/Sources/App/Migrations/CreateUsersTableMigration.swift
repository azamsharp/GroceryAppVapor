//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/22/23.
//

import Foundation
import Fluent

struct CreateUsersTableMigration: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required).unique(on: "username") // get username unique
            .field("password", .string, .required)
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("users")
            .delete()
    }
    
}
