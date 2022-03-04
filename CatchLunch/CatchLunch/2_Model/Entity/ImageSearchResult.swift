//
//  ImageSearchResult.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/27.
//

struct ImageSearchResult: Decodable {
    let items: [Item]?

    struct Item: Decodable {
        let thumbnail: String?
    }
}
