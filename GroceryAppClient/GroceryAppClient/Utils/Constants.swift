//
//  Constants.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let registerUrl = URL(string: "http://127.0.0.1:8080/api/register")!
    }
    
    struct Messages {
        static let usernameTaken = "Username is already taken."
        static let unknownError = "Error occured. Please try again later."
    }
    
}
