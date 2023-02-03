//
//  BookClub.swift
//  Book Club
//
//  Created by Nick Brenner on 1/30/23.
//

import Foundation

struct BookClub: Decodable {
    let id: Int
    let name: String
    let users: [User]
    let books: [Book]
}
