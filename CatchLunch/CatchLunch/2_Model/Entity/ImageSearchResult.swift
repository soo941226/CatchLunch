//
//  ImageSearchResult.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/27.
//

import Foundation

struct ImageSearchResult: Decodable {
    let items: [Item]?

    struct Item: Decodable {
        let thumbnail: String?
    }
}
