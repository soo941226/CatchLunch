//
//  ImageSearchError.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/18.
//

import Foundation

@frozen enum ImageSearchError: LocalizedError {
    case searchResultIsWrong
    case itemsIsNotExists
    case linkIsNotExists
    case urlIsWrong
    case imageDataIsWrong

    var errorDescription: String {
        switch self {
        case .searchResultIsWrong:
            return "응답 에러"
        case .itemsIsNotExists:
            return "items가 없옴"
        case .linkIsNotExists:
            return "응답이 잘 왔는데 내부에 링크가 없음"
        case .urlIsWrong:
            return "응답이 잘 왔는데 내부 링크가 이상함"
        case .imageDataIsWrong:
            return "링크로 이미지 가져왔더니 이상함"
        }
    }
}
