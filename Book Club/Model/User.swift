//
//  User.swift
//  Book Club
//
//  Created by Nick Brenner on 2/1/23.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
//    let user_bookclubs: [BookClub]
}
