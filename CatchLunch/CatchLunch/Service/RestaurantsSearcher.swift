//
//  RestaurantsSearcher.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

final class RestaurantsSearcher<NetworkManager: NetworkManagable>: SearchService {
    typealias completionHandler = (Result<[RestaurantInformation], Error>) -> Void
    
    private let decoder = JSONDecoder()
    private(set) var manager: NetworkManager

    required init(manager: NetworkManager) {
        self.manager = manager
    }

    func setUpRequest(request: URLRequest) {
        manager.setUpRequest(with: request)
    }

    func fetch(
        completionHandler: @escaping completionHandler
    ) {
        manager.dataTask { [weak self] result in
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
