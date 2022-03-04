//
//  RestaurantViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/28.
//

import Foundation
import UIKit

final class RestaurantViewModel<Service: PagingSearchService>: JustSearchViewModelable {
    private let service: Service

    private var managingItems = [RestaurantInformation]()
    var count: Int {
        return managingItems.count
    }

    private var nowLoading = false
    private(set) var error: Error?
    private var pageIndex = 1
    private let amount = 10

    init(service: Service) {
        self.service = service
    }

    subscript(_ index: Int) -> (restaurant: RestaurantInformation?, image: UIImage?) {
        managingItems.indices ~= index ? (managingItems[index], nil) : (nil, nil)
    }

    func fetch(completionHandler: @escaping (Bool) -> Void) {
        if nowLoading { return }

        nowLoading = true
        service.fetch(
            itemPageIndex: pageIndex,
            requestItemAmount: amount
        ) { result in
            self.nowLoading = false

            switch result {
            case .success(let restaurants):
                let restaurants = restaurants as! [RestaurantInformation]
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
