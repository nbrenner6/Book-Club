//
//  BookEntry.swift
//  Testing
//
//  Created by Nick Brenner on 1/27/23.
//

import Foundation

struct BookEntry : Decodable {
    let id: String
    let volumeInfo: VolumeInfo
    let searchInfo: SearchInfo
}

