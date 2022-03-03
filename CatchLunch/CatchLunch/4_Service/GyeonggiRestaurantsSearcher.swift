//
//  GyeonggiRestaurantsSearcher.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

struct GyeonggiRestaurantsSearcher: PagingSearchService {
    typealias Response = [RestaurantInformation]
    private let decoder = JSONDecoder()
    private(set) var manager: NetworkManagable

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
        itemPageIndex: Int,
        requestItemAmount: Int,
        completionHandler: @escaping CompletionHandler
    ) {
        let request = nextRequest(
            itemPageIndex: itemPageIndex, requestItemAmount: requestItemAmount
        )
        manager.setUpRequest(with: request)
        manager.dataTask { [self] result in
            switch result {
            case .success(let data):
                do {
                    let result = try self.decoder
                        .decode(GyeonggiAPIResult.self, from: data).place?[1]
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

fileprivate enum GyeonggiAPIConfigs {
    static let httpURL = "https://openapi.gg.go.kr/PlaceThatDoATasteyFoodSt"
}
