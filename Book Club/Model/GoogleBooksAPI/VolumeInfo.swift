//
//  VolumeInfo.swift
//  Testing
//
//  Created by Nick Brenner on 1/27/23.
//

import Foundation

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]
    let publishedDate: String
    let pageCount: Int
    let imageLinks: ImageLinks
}

