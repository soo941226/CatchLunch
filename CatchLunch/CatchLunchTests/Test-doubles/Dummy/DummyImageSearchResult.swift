//
//  DummyImageSearchResult.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/04.
//

import Foundation

final class DummyImageSearchResult {
    private lazy var bundle = Bundle(for: type(of: self))
    private(set) lazy var goodObject = """
    {
        "lastBuildDate": "Fri, 04 Mar 2022 13:48:07 +0900",
        "total": 72337,
        "start": 1,
        "display": 1,
        "items": [
            {
                "title": "삼겹살 | 기타 갤러리 - 무신사",
                "link": "https://image.musinsa.com/mfile_s01/2022/02/07/1c6d35881391cd2e65ff208a19f0afe8175131.jpg",
                "thumbnail": "file://\(bundle.path(forResource: "DummyImage", ofType: ".jpg")!)",
                "sizeheight": "480",
                "sizewidth": "640"
            }
        ]
    }
    """.data(using: .utf8)!

    //invalidDummyImageSearchResult
    let invalidObject = """
    {
        "lastBuildDate": "Fri, 04 Mar 2022 13:48:07 +0900",
        "total": 72337,
        "start": 1,
        "display": 1,
        "items": {
            "김치": "찌개"
        }
    }
    """.data(using: .utf8)!

    //dummyImageSearchResultWithEmptyItems
    let emptyItemsObject = """
    {
        "lastBuildDate": "Fri, 04 Mar 2022 13:48:07 +0900",
        "total": 72337,
        "start": 1,
        "display": 1,
        "items": []
    }
    """.data(using: .utf8)!

    //dummyImageSearchResultWithEmptyLink
    let emptyLinkObject = """
    {
           "lastBuildDate": "Fri, 04 Mar 2022 13:48:07 +0900",
           "total": 72337,
           "start": 1,
           "display": 1,
           "items": [
               {
                   "thumbnail": "",
               }
           ]
    }
    """.data(using: .utf8)!

    //dummyImageSearchResultWithInvalidData
    private(set) lazy var invalidLinkObject = """
    {
           "lastBuildDate": "Fri, 04 Mar 2022 13:48:07 +0900",
           "total": 72337,
           "start": 1,
           "display": 1,
           "items": [
               {
                   "thumbnail":"\(bundle.path(forResource: "DummyText", ofType: "txt")!)"
               }
           ]
    }
    """.data(using: .utf8)!

    //dummyImageSearchResultWithWrongData
    private(set) lazy var wrongDataObject = """
    {
           "lastBuildDate": "Fri, 04 Mar 2022 13:48:07 +0900",
           "total": 72337,
           "start": 1,
           "display": 1,
           "items": [
               {
                   "thumbnail":"file://\(bundle.path(forResource: "DummyText", ofType: "txt")!)"
               }
           ]
    }
    """.data(using: .utf8)!
}
