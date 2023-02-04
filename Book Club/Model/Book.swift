//
//  Book.swift
//  Book Club
//
//  Created by Nick Brenner on 2/1/23.
//

import Foundation

struct Book: Decodable {
    let id: Int
    let title: String
    let author: String
    let publishedDate: String
    let pageCount: Int
    let smallThumbnail: String
    let thumbnail: String
}
