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
        
        // api/users/:userId
        let api = routes.grouped("api", "users", ":userId")
        
        // POST /api/users/:userId/grocery-categories
        api.post("grocery-categories", use: create)
        // GET /api/users/:userId/grocery-categories
        api.get("grocery-categories", use: getByUser)
        // DELETE /api/users/:userId/grocery-categories/:groceryCategoryId
        api.delete("grocery-categories", ":groceryCategoryId", use: deleteGroceryCategory)
    }
    
    func deleteGroceryCategory(req: Request) async throws -> GroceryCategory {
        
        // get the id from the route parameters
        guard let userId = req.parameters.get("userId", as: UUID.self),
              let groceryCategoryId = req.parameters.get("groceryCategoryId", as: UUID.self)
        else {
            throw Abort(.badRequest)
        }
        
        guard let groceryCategory = try await GroceryCategory.find(groceryCategoryId, on: req.db) else {
            throw Abort(.badRequest)
        }
        
        // check the userId
        if userId == groceryCategory.userId {
            // delete the grocery category
            try await groceryCategory.delete(on: req.db)
        } else {
            throw Abort(.forbidden)
        }
        
        return groceryCategory
    }
    
    func getByUser(req: Request) async throws -> [GroceryCategory] {
        
        // get the id from the route parameters
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return try await GroceryCategory.query(on: req.db)
            .filter(\.$userId == userId)
            .all()
    }
    
    func create(req: Request) async throws -> GroceryCategory {
        
        // get the id from the route parameters
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        let groceryCategoryRequest = try req.content.decode(GroceryCategoryRequest.self)
        let groceryCategory = GroceryCategory(title: groceryCategoryRequest.title, color: groceryCategoryRequest.color, userId: userId)
        try await groceryCategory.save(on: req.db)
        return groceryCategory
    }
}
