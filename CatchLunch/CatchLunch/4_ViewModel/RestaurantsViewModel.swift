//
//  RestaurantsViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/28.
//

import UIKit

final class RestaurantsViewModel<Service: PagingSearchService>: PagingSearchViewModelable
where Service.Response == [RestaurantSummary] {
    private let service: Service
    private weak var restaurantsViewModel: RestaurantsViewModel<Service>?
    private weak var imageViewModel: ImageViewModel?
    private let imagePlaceHolder = UIImage.forkKnifeCircle

    private var nowLoading = false
    private var thereIsNoMoreItem = false
    private(set) var error: Error?

    private var sourtOfTruth = [RestaurantSummary]()
    private var pageIndex = 0
    private let itemRequestAmount = 10

    init(service: Service, imageViewModel: ImageViewModel) {
        self.service = service
        self.imageViewModel = imageViewModel
    }
}

// MARK: - Facade
extension RestaurantsViewModel: Notifier {
    var nextIndexPaths: [IndexPath] {
        let startIndex = pageIndex - 1
        guard startIndex >= .zero else {
            return []
        }
        let nextIndices = startIndex*itemRequestAmount..<sourtOfTruth.count
        return nextIndices.map { index in
            return IndexPath(row: index, section: .zero)
        }
    }

    var count: Int {
        return sourtOfTruth.count
    }

    subscript(_ index: Int) -> RestaurantInformation? {
        guard sourtOfTruth.indices ~= index else {
            return nil
        }

        let image = sourtOfTruth[index].mainFoodNames?.first
            .flatMap({ name in
                imageViewModel?[name]
            })

        return (sourtOfTruth[index], image ?? imagePlaceHolder)
    }

    func fetch(completionHandler: @escaping (Bool) -> Void) {
        if thereIsNoMoreItem { return }
        if nowLoading { return }
        nowLoading = true

        postStartTask()

        service.fetch(itemPageIndex: pageIndex, requestItemAmount: itemRequestAmount) { [weak self] result in
            guard let self = self else { return }
            self.nowLoading = false

            switch result {
            case .success(let restaurants):
                if restaurants.count > 0 {
                    self.fetchImages(from: restaurants, with: completionHandler)
                } else {
                    self.thereIsNoMoreItem = true
                    completionHandler(false)

                    self.postFinishTaskWithError(message: "더이상 요청할 수 없습니다")
                }
            case .failure(let error):
                self.error = error
                completionHandler(false)
            }
        }
    }

    func willDisappear() {
        postFinishTask()
    }
}

private extension RestaurantsViewModel {
    func fetchImages(
        from restaurants: [RestaurantSummary],
        with completionHandler: @escaping (Bool) -> Void
    ) {
        let dispatchGroup = DispatchGroup()

        restaurants.forEach { model in
            dispatchGroup.enter()
            let foodName = model.mainFoodNames?.first ?? ""
            imageViewModel?.fetch(about: foodName) { _ in
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.error = nil
            self?.pageIndex += 1
            self?.sourtOfTruth += restaurants
            completionHandler(true)
            self?.postFinishTask()
        }
    }
}
