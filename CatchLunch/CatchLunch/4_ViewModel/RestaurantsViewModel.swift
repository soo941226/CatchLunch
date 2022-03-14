//
//  RestaurantsViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/28.
//

import UIKit

final class RestaurantsViewModel<Service: PagingSearchService>: PagingSearchViewModelable
where Service.Response == [RestaurantInformation] {
    private let service: Service
    private let imageSearchViewModel = ImageViewModel(service: NaverImageSearcher())
    private let imagePlaceHolder = UIImage(systemName: "fork.knife.circle")!
    private var asset = [RestaurantInformation]()
    private let amount = 10
    private var pageIndex = 1
    private var nowLoading = false
    private var thereIsNoMoreItem = false
    private(set) var error: Error?
    private var itemStartIndex: Int? {
        let index = pageIndex - 2
        if index < 0 {
            return nil
        } else {
            return index
        }
    }

    init(service: Service) {
        self.service = service
    }
}

// MARK: - Facade
extension RestaurantsViewModel {
    var searchBarPlaceHolder: String {
        return "식당이름, 도시이름, 음식이름"
    }

    var managingItems: [RestaurantSummary] {
        return asset
            .map { restaurant in
                let image = restaurant.mainFoodNames?
                    .first
                    .flatMap({ name in
                        imageSearchViewModel[name]
                    })

                if let image = image {
                    return (restaurant, image)
                } else {
                    return (restaurant, imagePlaceHolder)
                }
            }
    }
    
    var nextItems: [RestaurantSummary] {
        guard let startIndex = itemStartIndex else {
            return []
        }
        let nextIndices = startIndex*amount..<asset.count

        return asset[nextIndices]
            .map { restaurant in
                let image = restaurant.mainFoodNames?
                    .first
                    .flatMap({ name in
                        imageSearchViewModel[name]
                    })

                if let image = image {
                    return (restaurant, image)
                } else {
                    return (restaurant, imagePlaceHolder)
                }
            }
    }

    var nextIndexPaths: [IndexPath] {
        guard let startIndex = itemStartIndex else {
            return []
        }
        let nextIndices = startIndex*amount..<asset.count
        return nextIndices.map { index in
            return IndexPath(row: index, section: .zero)
        }
    }

    subscript(_ index: Int) -> RestaurantSummary? {
        guard asset.indices ~= index else {
            return nil
        }

        let image = asset[index].mainFoodNames?.first
            .flatMap({ name in
                imageSearchViewModel[name]
            })

        return (asset[index], image ?? imagePlaceHolder)
    }

    func fetch(completionHandler: @escaping (Bool) -> Void) {
        if thereIsNoMoreItem { return }
        if nowLoading { return }
        nowLoading = true

        NotificationCenter.default.post(name: .startTask, object: nil)

        service.fetch(
            itemPageIndex: pageIndex,
            requestItemAmount: amount
        ) { result in
            self.nowLoading = false

            switch result {
            case .success(let restaurants):
                if restaurants.count > 0 {
                    self.fetchImages(from: restaurants, with: completionHandler)
                } else {
                    self.thereIsNoMoreItem = true
                    completionHandler(false)

                    NotificationCenter.default.post(
                        name: .finishTaskWithError, object: nil,
                        userInfo: ["message": "더이상 요청할 수 없습니다"]
                    )
                }
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

        restaurants.forEach { model in
            dispatchGroup.enter()
            let foodName = model.mainFoodNames?.first ?? ""
            imageSearchViewModel.fetch(about: foodName) { _ in
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.error = nil
            self?.pageIndex += 1
            self?.asset += restaurants
            completionHandler(true)
            NotificationCenter.default.post(name: .finishTask, object: nil)
        }
    }
}
