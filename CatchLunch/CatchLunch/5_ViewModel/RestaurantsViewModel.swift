//
//  RestaurantsViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/28.
//

import UIKit

final class RestaurantsViewModel<Service: PagingSearchService>: JustSearchViewModelable
where Service.Response == [RestaurantInformation] {
    private let service: Service
    private let imageSearchViewModel = ImageViewModel(service: NaverImageSearcher())
    private let imagePlaceHolder = UIImage(systemName: "fork.knife.circle")!

    private var managingItems = [RestaurantInformation]()

    var count: Int {
        return managingItems.count
    }

    private let amount = 10
    private var pageIndex = 1
    private var nowLoading = false
    private(set) var error: Error?

    init(service: Service) {
        self.service = service
    }

    subscript(_ index: Int) -> (restaurant: RestaurantInformation, image: UIImage)? {
        guard managingItems.indices ~= index else {
            return nil
        }

        let image = managingItems[index].mainFoodNames?.first
            .flatMap({ name in
                imageSearchViewModel[name]
            })

        return (managingItems[index], image ?? imagePlaceHolder)
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
                self.fetchImages(from: restaurants, with: completionHandler)
            case .failure(let error):
                self.error = error
                completionHandler(false)
            }
        }
    }

    private func fetchImages(
        from restaurants: [RestaurantInformation],
        with completionHandler: @escaping (Bool) -> Void
    ) {
        let dispatchGroup = DispatchGroup()

        restaurants.forEach { information in
            information.mainFoodNames?.forEach({ foodName in
                dispatchGroup.enter()

                imageSearchViewModel.fetch(about: foodName) { _ in
                    dispatchGroup.leave()
                }
            })
        }

        dispatchGroup.notify(queue: .main) {
            self.error = nil
            self.pageIndex += 1
            self.managingItems += restaurants
            completionHandler(true)
        }
    }
}
