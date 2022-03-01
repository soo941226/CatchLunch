//
//  NetworkError.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

@frozen enum NetworkError: LocalizedError {
    case requestIsNotExist
    case dataIsNotExist
    case clientError(code: Int)
    case serverError(code: Int)

    var errorDescription: String {
        switch self {
        case .requestIsNotExist:
            return "요청이 설정되지 않았습니다"
        case .dataIsNotExist:
            return "서버 응답에 데이터가 존재하지 않습니다"
        case .clientError(let code):
            return "Client Error: \(code.description)"
        case .serverError(let code):
            return "Server Error: \(code.description)"
        }
    }
}
