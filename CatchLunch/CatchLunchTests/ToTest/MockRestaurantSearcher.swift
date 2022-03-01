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
    init(manager: MockRestaurantNetworkManager = MockRestaurantNetworkManager()) {
        self.manager = manager
    }

    func setUpRequest(request: URLRequest) {
        manager.setUpRequest(with: request)
    }

    func fetch(completionHandler: @escaping (Result<[RestaurantInformation], Error>) -> Void) {
        manager.dataTask { result in
            switch result {
            case .success(let data):
                let result = try? self.decoder.decode(Response.self, from: data)

                if let result = result {
                    completionHandler(.success(result))
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

enum ErrorMockRestaurantSearcher: Error {
    case decodingFailed
}
