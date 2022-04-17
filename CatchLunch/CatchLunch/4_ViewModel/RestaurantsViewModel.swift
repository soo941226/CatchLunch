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

    private var nowLoading = false
    private var thereIsNoMoreItem = false
    private(set) var error: Error?

    private var sourtOfTruth = [RestaurantSummary]()
    private var pageIndex = 0
    private let itemRequestAmount = 100

    init(service: Service) {
        self.service = service
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

    subscript(_ index: Int) -> RestaurantSummary? {
        guard sourtOfTruth.indices ~= index else {
            return nil
        }

        return sourtOfTruth[index]
    }

    func search(completionHandler: @escaping (Bool) -> Void) {
        if thereIsNoMoreItem { return }
        if nowLoading { return }
        nowLoading = true

        postStartTask()

        service.fetch(pageIndex: pageIndex, requestItemAmount: itemRequestAmount) { [weak self] result in
            guard let self = self else { return }
            self.nowLoading = false

            switch result {
            case .success(let restaurants):
                if restaurants.count > 0 {
                    self.success(with: restaurants, by: completionHandler)
                } else {
                    self.end(by: completionHandler)
                }
            case .failure(let error):
                self.failure(with: error, by: completionHandler)
            }
        }
    }

    func willDisappear() {
        postFinishTask()
    }

}

// MARK: - components of fetch
private extension RestaurantsViewModel {
    func success(with restaurants: [RestaurantSummary], by completionHandler: @escaping (Bool) -> Void) {
        error = nil
        pageIndex += 1
        sourtOfTruth += restaurants

        DispatchQueue.main.async {
            completionHandler(true)

            self.postFinishTask()
        }
    }

    func end(by completionHandler: @escaping (Bool) -> Void) {
        thereIsNoMoreItem = true

        DispatchQueue.main.async {
            completionHandler(false)

            self.postFinishTaskWithError(message: "더이상 요청할 수 없습니다")
        }
    }

    func failure(with error: Error, by completionHandler: @escaping (Bool) -> Void) {
        self.error = error
        DispatchQueue.main.async {
            completionHandler(false)
        }
    }
}
