//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/25/23.
//

import Foundation
import Vapor
import Fluent


class GroceryController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        let api = routes.grouped("api")
        api.post("grocery-categories", use: create)
    }
    
    func create(req: Request) async throws -> GroceryCategory {
        
        let groceryCategory = try req.content.decode(GroceryCategory.self)
        try await groceryCategory.save(on: req.db)
        return groceryCategory
    }
}
