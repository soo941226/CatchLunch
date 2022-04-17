//
//  GyeonggiParagonRestaurantSearcher.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/21.
//

import Foundation

struct GyeonggiParagonRestaurantSearcher: PagingSearchService {
    typealias Response = [RestaurantSummary]
    private let decoder = JSONDecoder()
    private let manager: NetworkManagable

    init(manager: NetworkManagable = NetworkManager()) {
        self.manager = manager
    }

    private func nextRequest(itemPageIndex: Int, requestItemAmount: Int) -> URLRequest {
        var urlComponent = URLComponents(string: GyeonggiAPIConfigs.httpURL)!
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
            itemPageIndex: pageIndex+1, requestItemAmount: requestItemAmount
        )
        manager.setUpRequest(with: request)
        manager.dataTask { result in
            switch result {
            case .success(let data):
                do {
                    let result = try self.decoder
                        .decode(GyeonggiParagonRestaurantsAPIResult.self, from: data).place?.last?
                        .row?
                        .compactMap { restaurant in
                            RestaurantSummary(from: restaurant)
                        }

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

private enum GyeonggiAPIConfigs {
    static let httpURL = "https://openapi.gg.go.kr/ParagonRestaurant"
}
