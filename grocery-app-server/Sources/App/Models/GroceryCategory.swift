//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/25/23.
//

import Foundation
import Vapor
import Fluent 

final class GroceryCategory: Model, Content,  Validatable {
    
    static let schema = "grocery_categories"

    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "color")
    var color: String
    
    @Parent(key: "user_id")
    var user: User
    
    @Children(for: \.$groceryCategory)
    var items: [GroceryItem]
    
    init() { }
    
    init(id: UUID? = nil, title: String, color: String, userId: UUID) {
        self.title = title
        self.color = color
        self.$user.id = userId
    }
    
    static func validations(_ validations: inout Validations) {
        
        // add validations
        validations.add("title", as: String.self, is: !.empty, customFailureDescription: "Title cannot be empty.")
        validations.add("color", as: String.self, is: !.empty, customFailureDescription: "Color cannot be empty.")
    }
}
