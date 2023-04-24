//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/24/23.
//

import Foundation
import Vapor

struct RegistrationResponse: Content {
    let error: Bool
    var reason: String? = nil 
}
