//
//  LoginResponse.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/24/23.
//

import Foundation

struct LoginResponse: Decodable {
    let error: Bool
    let reason: String?
    let token: String?
}
