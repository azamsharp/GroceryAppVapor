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
        
        // /api/users
        let api = routes.grouped("api", "users")
        
        // POST: /api/users/:userId/grocery-categories
        api.post(":userId", "grocery-categories", use: saveGroceryCategory)
        // GET: /api/users/:userId/grocery-categories
        api.get(":userId", "grocery-categories", use: getGroceryCategoriesByUser)
        // DELETE: /api/users/:userId/grocery-categories/:groceryCategoryId
        api.delete(":userId", "grocery-categories", ":groceryCategoryId", use: deleteGroceryCategory)
        /*
        // api/users/:userId
        let api = routes.grouped("api", "users", ":userId")
        
        // POST /api/users/:userId/grocery-categories
        api.post("grocery-categories", use: saveGroceryCategory)
        // GET /api/users/:userId/grocery-categories
        api.get("grocery-categories", use: getGroceryCategoriesByUser)
        // DELETE /api/users/:userId/grocery-categories/:groceryCategoryId
        //api.delete("grocery-categories", ":groceryCategoryId", use: deleteGroceryCategory)
        
        // POST /api/users/:userId/grocery-categories/:groceryCategoryId/grocery-items
        api.post("grocery-categories", ":groceryCategoryId", "grocery-items", use: saveGroceryItem)
         */
    }
    
    func saveGroceryItem(req: Request) async throws -> GroceryItem {
        
        guard let userId = req.parameters.get("userId", as: UUID.self),
              let groceryCategoryId = req.parameters.get("groceryCategoryId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        
        
        // get the grocery category based on userId and grocery categoryId
        //let groceryCategory = try await GroceryCategory.query(on: req.db)
          //  .filter(\.$userId == userId)
            //.filter(\.$id == groceryCategoryId)
            //.first()
        
        return GroceryItem()
        //return groceryCategory
    }
    
    func deleteGroceryCategory(req: Request) async throws -> GroceryCategoryResponse {
        
        // get the id from the route parameters
        guard let userId = req.parameters.get("userId", as: UUID.self),
              let groceryCategoryId = req.parameters.get("groceryCategoryId", as: UUID.self)
        else {
            throw Abort(.badRequest)
        }
        
        guard let groceryCategory = try await GroceryCategory.query(on: req.db)
            .filter(\.$user.$id == userId)
            .filter(\.$id == groceryCategoryId)
            .first() else {
            throw Abort(.badRequest)
        }
        
        try await groceryCategory.delete(on: req.db)
        
        guard let groceryCategoryResponse = GroceryCategoryResponse(groceryCategory: groceryCategory) else {
            throw Abort(.internalServerError)
        }
        
        return groceryCategoryResponse
    }
    
    // get grocery categories by user
    func getGroceryCategoriesByUser(req: Request) async throws -> [GroceryCategoryResponse] {
        
        // get the id from the route parameters
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return try await GroceryCategory.query(on: req.db)
            // get all grocery categories where userId is matching userId
            .filter(\.$user.$id == userId)
            .all()
            .compactMap(GroceryCategoryResponse.init)
    }
    
    // POST: api/grocery-categories
    func saveGroceryCategory(req: Request) async throws -> GroceryCategoryResponse {
        
        // get the id from the route parameters
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        let groceryCategoryRequest = try req.content.decode(GroceryCategoryRequest.self)
        
        let groceryCategory = GroceryCategory(title: groceryCategoryRequest.title, color: groceryCategoryRequest.color, userId: userId)
        
        try await groceryCategory.save(on: req.db)
        
        guard let groceryCategoryResponse = GroceryCategoryResponse(groceryCategory: groceryCategory) else {
            throw Abort(.internalServerError)
        }
        
        return groceryCategoryResponse
        
    }
}
