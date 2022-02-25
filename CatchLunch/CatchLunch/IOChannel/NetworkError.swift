//
//  NetworkError.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

@frozen enum NetworkError: Error {
    case requestIsNotExist
    case dataIsNotExist
    case clientError(code: Int, description: String)
    case serverError(code: Int, description: String)

    var errorDescription: String {
        switch self {
        case .requestIsNotExist:
            return "요청이 설정되지 않았습니다"
        case .dataIsNotExist:
            return "서버 응답에 데이터가 존재하지 않습니다"
        case .clientError(let code, let description):
            return "Client Error(\(code.description)): \(description)"
        case .serverError(let code, let description):
            return "Server Error(\(code.description)): \(description)"
        }
    }
}
