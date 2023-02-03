//
//  SessionToken.swift
//  Book Club
//
//  Created by Nick Brenner on 2/1/23.
//

import Foundation

struct SessionToken: Codable {
    let session_token: String
    let session_expiration: String
    let update_token: String
    let user_id: Int
}

