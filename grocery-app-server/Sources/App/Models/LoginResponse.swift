//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/25/23.
//

import Foundation
import Vapor

struct LoginResponse: Content {
    let error: Bool
    var reason: String? = nil
    let token: String?
}
