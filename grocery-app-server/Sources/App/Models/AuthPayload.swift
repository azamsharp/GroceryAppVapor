//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/22/23.
//

import Foundation
import JWT
import Vapor

struct AuthPayload: JWTPayload, Authenticatable {
    
    typealias Payload = AuthPayload
    
    enum CodingKeys: String, CodingKey {
        case userId = "uid"
        case expiration = "exp"
    }
    var userId: UUID
    var expiration: ExpirationClaim
    
    func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
    
}
