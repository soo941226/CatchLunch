//
//  MapRouterError.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/29.
//

import Foundation

@frozen enum MapRouterError: LocalizedError {
    case locationsIsEmpty
    case failedToRoute

    var errorDescription: String {
        switch self {
        case .locationsIsEmpty:
            return "현재 위치를 읽어올 수 없습니다"
        case .failedToRoute:
            return "경로를 찾는데 실패했습니다. 문제가 반복되면 개발자에게 알려주세요!"
        }
    }
}
