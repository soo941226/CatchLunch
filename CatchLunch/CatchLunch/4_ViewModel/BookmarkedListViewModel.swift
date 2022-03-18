//
//  BookmarkedListViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/14.
//

import UIKit

final class BookmarkedListViewModel<Service: BookmarkService>: JustSearchViewModelable
where Service.Response == RestaurantInformation {
    private let service: Service
    private let imageSearchViewModel = ImageViewModel(service: NaverImageSearcher())
    private let imagePlaceHolder = UIImage(systemName: "fork.knife.circle")!
    private var asset = [RestaurantInformation]()
    private var nowLoading = false

    private(set) var error: Error?

    init(service: Service) {
        self.service = service
    }
}

// MARK: - Facade
extension BookmarkedListViewModel {
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
        if nowLoading { return }
        nowLoading = true

        NotificationCenter.default.post(name: .startTask, object: nil)

        service.fetch(whereBookmarkedIs: true) { [weak self] result in
            self?.nowLoading = false

            switch result {
            case .success(let restaurants):
                self?.fetchImagesToFinish(from: restaurants, with: completionHandler)
            case .failure(let error):
                self?.error = error
                completionHandler(false)
            }
        }
    }

    private func fetchImagesToFinish(
        from restaurants: [RestaurantInformation],
        with completionHandler: @escaping (Bool) -> Void
    ) {
        guard restaurants.count > .zero else {
            asset = []
            NotificationCenter.default.post(name: .finishTask, object: nil)
            completionHandler(true)
            return
        }

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
            self?.asset = restaurants
            completionHandler(true)
            NotificationCenter.default.post(name: .finishTask, object: nil)
        }
    }
}