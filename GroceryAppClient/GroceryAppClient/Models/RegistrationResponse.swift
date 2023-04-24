//
//  RegistrationResponse.swift
//  GroceryAppClient
//
//  Created by Mohammad Azam on 4/23/23.
//

import Foundation

struct RegistrationResponse: Decodable {
    let error: Bool
    let reason: String? 
}
