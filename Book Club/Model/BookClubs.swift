//
//  BookClubs.swift
//  Book Club
//
//  Created by Nick Brenner on 2/2/23.
//

import Foundation
import UIKit

struct UserBookClubs: Decodable {
    let user_bookclubs: [BookClub]
}

struct GeneralBookClubs: Decodable {
    let bookclubs: [BookClub]
}
