//
//  DaumImageSearchResult.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/20.
//

struct DaumImageSearchResult: Decodable {
    let items: [Document]?

    enum CodingKeys: String, CodingKey {
        case items = "documents"
    }
}

struct Document: Decodable {
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "thumbnail_url"
    }
}
