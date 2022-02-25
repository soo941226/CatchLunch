//
//  RestaurantsSearcher.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

final class RestaurantsSearcher: RestaurantsSearchService  {
    typealias completionHandler = (Result<[RestaurantInformation], Error>) -> Void
    
    private let channel: NetworkManagable
    private let decoder = JSONDecoder()

    init(channel: NetworkManagable) {
        self.channel = channel
    }

    func fetchRestaurant(
        pageIndex: Int,
        completionHandler: @escaping completionHandler
    ) {
        channel.dataTask { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    let result = try self.decoder
                        .decode([RestaurantInformation].self, from: data)

                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
