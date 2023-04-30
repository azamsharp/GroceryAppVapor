//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/30/23.
//

import Foundation
import Vapor
import Fluent 

final class GroceryItem: Model, Content {
    
    static let schema = "grocery-items"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "price")
    var price: Double
    
    @Field(key: "quantity")
    var quantity: Int
    
    // refer to the parent
    @Parent(key: "grocery_category_id")
    var groceryCategory: GroceryCategory
    
    //@Field(key: "grocery_category_id")
    //var groceryCategoryId: UUID
    
    init() { }
    
    init(id: UUID? = nil, title: String, price: Double, quantity: Int) {
        self.id = id
        self.title = title
        self.price = price
        self.quantity = quantity
    }
}
