//
//  RestaurantSearchViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/28.
//

import Foundation

struct GyeonggiRestaurantSearchViewModel<Service: SearchService>: SearchViewModelable
where Service.Request == URLRequest, Service.Response == [RestaurantInformation] {
    private(set) var service: Service
    private var managingData = [RestaurantInformation]()
    var count: Int {
        return managingData.count
    }

    init(service: Service) {
        self.service = service
    }

    subscript(index: Int) -> RestaurantInformation? {
        managingData.indices ~= index ? managingData[index] : nil
    }

    func fetch(completionHandler: @escaping (Bool) -> Void) {
        print(nextRequest?.description)
    }

    private let requestItemAmount = 10
    private var index = 1
    private var nextRequest: URLRequest? {
        guard var urlComponent = URLComponents(string: GyeonggiAPIConfigs.httpURL) else {
            return nil
        }

        urlComponent.queryItems = [
            .init(name: "Key", value: HiddenConfiguration.gyeonggiApiKey),
            .init(name: "Type", value: "json"),
            .init(name: "pIndex", value: index.description),
            .init(name: "pSize", value: requestItemAmount.description)
        ]

        if let url = urlComponent.url {
            return URLRequest(url: url)
        } else {
            return nil
        }
    }
}


fileprivate enum GyeonggiAPIConfigs {
    static let httpURL = "https://openapi.gg.go.kr/PlaceThatDoATasteyFoodSt"
}
