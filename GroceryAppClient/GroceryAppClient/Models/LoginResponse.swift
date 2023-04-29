//
//  LoginResponse.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/24/23.
//

import Foundation

struct LoginResponse: Codable {
    let error: Bool
    let reason: String?
    let token: String?
    let userId: UUID
}
