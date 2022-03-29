//
//  MapRoutingError.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/29.
//

import Foundation

@frozen enum MapRoutingError: LocalizedError {
    case authorityIsInsufficient
    case locationsIsEmpty
    case placemarksIsEmpty
    case failedToRoute

    var errorDescription: String {
        switch self {
        case .authorityIsInsufficient:
            return "권한을 할당받지 못해 서비스를 사용할 수 없습니다"
        case .locationsIsEmpty:
            return "현재 위치를 읽어올 수 없습니다"
        case .placemarksIsEmpty:
            return "애플 서비스에 문제가 발생하여 현재 위치를 나타낼 수 없습니다"
        case .failedToRoute:
            return "경로를 찾는데 실패했습니다. 문제가 반복되면 개발자에게 알려주세요!"
        }
    }
}
