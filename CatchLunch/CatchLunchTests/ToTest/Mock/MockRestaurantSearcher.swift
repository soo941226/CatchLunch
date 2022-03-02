//
//  MyMockRestaurantSearcher.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/01.
//

import Foundation
@testable import CatchLunch

final class MockRestaurantSearcher: SearchService {
    private(set) var manager: MockRestaurantNetworkManager

    private let decoder = JSONDecoder()
    private var index = 0
    init(manager: MockRestaurantNetworkManager = MockRestaurantNetworkManager()) {
        self.manager = manager
    }

    func setUpRequest(request: URLRequest) {
        if index <= 3 {
            manager.setUpRequest(with: request)
        } else {
            manager.setUpRequest(with: .criticalError)
        }
    }

    func fetch(completionHandler: @escaping (Result<[RestaurantInformation], Error>) -> Void) {
        manager.dataTask { result in
            switch result {
            case .success(let data):
                let result = try? self.decoder.decode(Response.self, from: data)

                if let result = result {
                    let index = self.index
                    let endIndex = result.endIndex
                    let startOfRange = index * 10

                    if startOfRange >= endIndex {
                        return completionHandler(.failure(
                            NetworkError.dataIsNotExist
                        ))
                    }

                    let endOfRange = (index+1) * 10 >= endIndex ? endIndex : (index+1) * 10
                    let range = startOfRange..<endOfRange
                    self.index += 1

                    completionHandler(.success(Array(result[range])))
                } else {
                    completionHandler(.failure(
                        ErrorMockRestaurantSearcher.decodingFailed
                    ))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

enum ErrorMockRestaurantSearcher: LocalizedError {
    case decodingFailed

    var errorDescription: String {
        return "decodingFailed"
    }
}
