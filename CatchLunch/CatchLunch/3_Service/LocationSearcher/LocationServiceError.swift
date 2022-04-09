//
//  LocationServiceError.swift
//  CatchLunch
//
//  Created by kjs on 2022/04/08.
//

import Foundation

@frozen enum LocationServiceError: LocalizedError {
    case authorityIsInsufficient
    case placemarksIsEmpty

    var errorDescription: String {
        switch self {
        case .authorityIsInsufficient:
            return "권한을 할당받지 못해 서비스를 사용할 수 없습니다"
        case .placemarksIsEmpty:
            return "애플 서비스에 문제가 발생하여 현재 위치를 나타낼 수 없습니다"
        }
    }
}
