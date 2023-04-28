//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/25/23.
//

import Foundation
import Vapor
import Fluent


// all these routes needs to be protected 
class GroceryController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        let api = routes.grouped("api", "users")
        
        // POST /api/users/:id/grocery-categories
        api.post(":id", "grocery-categories", use: create)
        // GET /api/users/:id/grocery-categories
        api.get(":id", "grocery-categories", use: getByUser)
    }
    
    func getByUser(req: Request) async throws -> [GroceryCategory] {
        
        // get the id from the route parameters
        guard let userId = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return try await GroceryCategory.query(on: req.db)
            .filter(\.$userId == userId)
            .all()
    }
    
    func create(req: Request) async throws -> GroceryCategory {
        
        // get the id from the route parameters
        guard let userId = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        let groceryCategoryRequest = try req.content.decode(GroceryCategoryRequest.self)
        let groceryCategory = GroceryCategory(title: groceryCategoryRequest.title, color: groceryCategoryRequest.color, userId: userId)
        try await groceryCategory.save(on: req.db)
        return groceryCategory
    }
}
