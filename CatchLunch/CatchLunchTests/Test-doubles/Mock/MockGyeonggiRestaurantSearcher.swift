//
//  MyMockRestaurantSearcher.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/01.
//

import Foundation
@testable import CatchLunch

final class MockGyeonggiRestaurantSearcher: PagingSearchService {
    typealias Response = [RestaurantSummary]
    private let decoder = JSONDecoder()
    private let manager: NetworkManagable

    init(manager: NetworkManagable = MockRestaurantNetworkManager()) {
        self.manager = manager
    }

    private func nextRequest(itemPageIndex: Int, requestItemAmount: Int) -> URLRequest {
        var urlComponent = URLComponents(string: "https://dummyurl.com")!
        urlComponent.queryItems = [
            .init(name: "KEY", value: HiddenConfiguration.gyeonggiAPIKey),
            .init(name: "Type", value: "json"),
            .init(name: "pIndex", value: itemPageIndex.description),
            .init(name: "pSize", value: requestItemAmount.description)
        ]
        return URLRequest(url: urlComponent.url!)
    }

    func fetch(
        pageIndex: Int,
        requestItemAmount: Int,
        completionHandler: @escaping CompletionHandler
    ) {
        let request = nextRequest(
            itemPageIndex: pageIndex, requestItemAmount: requestItemAmount
        )
        manager.setUpRequest(with: request)
        manager.dataTask { result in
            switch result {
            case .success(let data):
                do {
                    let result = try self.decoder
                        .decode(GyeonggiRestaurantsAPIResult.self, from: data).place?.last?
                        .row

                    if let result = result {
                        completionHandler(.success(result))
                    } else {
                        completionHandler(.success([]))
                    }
                } catch {
                    completionHandler(.failure(error))
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
