//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/22/23.
//

import Vapor
import Fluent

class UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        
        let api = routes.grouped("api")
        // /api/login
        api.post("login", use: login)
        // /api/register
        api.post("register", use: register)
    }
    
    func login(req: Request) async throws -> [String: String] {
        
        // decode it
        let user = try req.content.decode(User.self)
       
        guard let existingUser = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() else {
                throw Abort(.badRequest)
        }
        
        // validate the password using hash
        let result = try await req.password.async.verify(user.password, created: existingUser.password)
        
        if !result {
            throw Abort(.unauthorized)
        }
        
        // generate the token and put userId in the token
        let authPayload = AuthPayload(userId: existingUser.id!, expiration: .init(value: .distantFuture))
        
        return try [
            "token": req.jwt.sign(authPayload)
        ]
    }
    
    func register(req: Request) async throws -> User {
        
        // validate the request
        try User.validate(content: req)
        
        let user = try req.content.decode(User.self)
        // hash the password
        user.password = try await req.password.async.hash(user.password)
        try await user.save(on: req.db)
        return user
    }
    
}
