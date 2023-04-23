//
//  File.swift
//  
//
//  Created by Mohammad Azam on 4/22/23.
//

import Foundation
import JWT

struct AuthPayload: JWTPayload {
    
    enum CodingKeys: String, CodingKey {
        //case subject = "sub"
        case userId = "uid"
        case expiration = "exp"
        //case isAdmin = "admin"
    }
    
    
    
    //var subject: SubjectClaim
    
    // userId of the user. This cannot be nil since we are creating the payload it after the user logs in
    var userId: UUID
    var expiration: ExpirationClaim
    
    //var isAdmin: Bool
    
    func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
    
}
