//
//  File.swift
//  
//
//  Created by Mohammad Azam on 5/3/23.
//

import Foundation
import Vapor 

struct JSONWebTokenAuthenticator: AsyncRequestAuthenticator {
    
    func authenticate(request: Vapor.Request) async throws {
        try request.jwt.verify(as: AuthPayload.self)
    }
    
}
