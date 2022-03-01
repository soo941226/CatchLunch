//
//  GyeonggiRestaurantViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/28.
//

import Foundation

final class GyeonggiRestaurantViewModel<Service: SearchService>: SearchViewModelable
where Service.Response == [RestaurantInformation] {
    private(set) var service: Service

    private var managingItems = [RestaurantInformation]()
    private let requestItemAmount = 10
    private var itemPageIndex = 1
    private var nextRequest: URLRequest? {
        guard var urlComponent = URLComponents(string: GyeonggiAPIConfigs.httpURL) else {
            return nil
        }

        urlComponent.queryItems = [
            .init(name: "Key", value: HiddenConfiguration.gyeonggiAPIKey),
            .init(name: "Type", value: "json"),
            .init(name: "pIndex", value: itemPageIndex.description),
            .init(name: "pSize", value: requestItemAmount.description)
        ]

        if let url = urlComponent.url {
            return URLRequest(url: url)
        } else {
            return nil
        }
    }
    private var error: Error?
    private var nowLoading = false

    var count: Int {
        return managingItems.count
    }

    init(service: Service) {
        self.service = service
    }

    subscript(index: Int) -> RestaurantInformation? {
        managingItems.indices ~= index ? managingItems[index] : nil
    }

    func fetch(completionHandler: @escaping (Bool) -> Void) {
        if nowLoading { return }

        guard let request = nextRequest else {
            completionHandler(false)
            return
        }

        nowLoading = true

        service.setUpRequest(request: request)
        service.fetch { [weak self] result in
            guard let self = self else { return }
            self.nowLoading = false

            switch result {
            case .success(let restaurants):
                self.error = nil
                self.managingItems += restaurants
                completionHandler(true)
            case .failure(let error):
                self.error = error
                completionHandler(false)
            }
        }
    }
}


fileprivate enum GyeonggiAPIConfigs {
    static let httpURL = "https://openapi.gg.go.kr/PlaceThatDoATasteyFoodSt"
}
