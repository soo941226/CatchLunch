//
//  dummyImageSearchResult.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/04.
//


let goodDummyImageSearchResult = """
{
    "lastBuildDate": "Fri, 04 Mar 2022 13:48:07 +0900",
    "total": 72337,
    "start": 1,
    "display": 1,
    "items": [
        {
            "title": "삼겹살 | 기타 갤러리 - 무신사",
            "link": "https://image.musinsa.com/mfile_s01/2022/02/07/1c6d35881391cd2e65ff208a19f0afe8175131.jpg",
            "thumbnail": "file:/Users/kjs/Documents/dev/prjs/CatchLunch/CatchLunch/CatchLunchTests/ToTest/Dummy/dummyImage.jpg",
            "sizeheight": "480",
            "sizewidth": "640"
        }
    ]
}
"""

let invalidDummyImageSearchResult = """
{
    "lastBuildDate": "Fri, 04 Mar 2022 13:48:07 +0900",
    "total": 72337,
    "start": 1,
    "display": 1,
    "items": {
        "김치": "찌개"
    }
}
"""

let dummyImageSearchResultWithEmptyItems = """
{
    "lastBuildDate": "Fri, 04 Mar 2022 13:48:07 +0900",
    "total": 72337,
    "start": 1,
    "display": 1,
    "items": []
}
"""

let dummyImageSearchResultWithEmptyLink = """
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
"""

let dummyImageSearchResultWithInvalidData = """
{
       "lastBuildDate": "Fri, 04 Mar 2022 13:48:07 +0900",
       "total": 72337,
       "start": 1,
       "display": 1,
       "items": [
           {
               "thumbnail": "file:/Users/kjs/Documents/dev/prjs/CatchLunch/CatchLunch/CatchLunchTests/ToTest/Dummy/dummy",
           }
       ]
}
"""

let dummyImageSearchResultWithWrongData = """
{
       "lastBuildDate": "Fri, 04 Mar 2022 13:48:07 +0900",
       "total": 72337,
       "start": 1,
       "display": 1,
       "items": [
           {
               "thumbnail": "file:/Users/kjs/Documents/dev/prjs/CatchLunch/CatchLunch/CatchLunchTests/ToTest/Dummy/dummyText.txt"
           }
       ]
}
"""
