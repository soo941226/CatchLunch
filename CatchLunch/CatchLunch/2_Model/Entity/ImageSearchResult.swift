//
//  ImageSearchResult.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/27.
//

import Foundation

struct ImageSearchResult: Codable {
    let items: [Item]?

    struct Item: Codable {
        let thumbnail: String?
    }
}
