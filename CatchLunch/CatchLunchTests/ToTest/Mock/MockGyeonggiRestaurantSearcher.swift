//
//  MyMockRestaurantSearcher.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/01.
//

import Foundation
@testable import CatchLunch

final class MockGyeonggiRestaurantSearcher: PagingSearchService {
    typealias Response = [RestaurantInformation]

    private(set) var manager: MockRestaurantNetworkManager

    private let decoder = JSONDecoder()
    init(manager: MockRestaurantNetworkManager = MockRestaurantNetworkManager()) {
        self.manager = manager
    }

    func fetch(
        itemPageIndex: Int,
        requestItemAmount: Int,
        completionHandler: @escaping CompletionHandler
    ) {
        if itemPageIndex == .zero {
            manager.setUpRequest(with: .dataIsNotExist)
        } else if itemPageIndex <= 3 {
            manager.setUpRequest(with: .dummyRestaurantData)
        }

        manager.dataTask { result in
            switch result {
            case .success(let data):
                let result = try? self.decoder
                    .decode(GyeonggiAPIResult.self, from: data).place?.last?
                    .row

                if let result = result {
                    let index = itemPageIndex
                    let endIndex = result.endIndex
                    let startOfRange = index * requestItemAmount

                    if startOfRange >= endIndex {
                        return completionHandler(.failure(
                            NetworkError.dataIsNotExist
                        ))
                    }

                    let endOfRange = (index+1) * requestItemAmount >= endIndex ? endIndex : (index+1) * requestItemAmount
                    let range = startOfRange..<endOfRange

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
