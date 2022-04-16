//
//  BookmarkedListViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/14.
//

import UIKit

final class BookmarkedListViewModel<Service: BookmarkService>: JustSearchViewModelable
where Service.Response == RestaurantSummary {
    private let service: Service
    private var sourceOfTruth = [RestaurantSummary]()
    private var nowLoading = false

    private(set) var error: Error?

    init(service: Service) {
        self.service = service
    }
}

// MARK: - Facade
extension BookmarkedListViewModel: Notifier {
    var count: Int {
        return sourceOfTruth.count
    }

    subscript(_ index: Int) -> RestaurantSummary? {
        guard sourceOfTruth.indices ~= index else {
            return nil
        }

        return sourceOfTruth[index]
    }

    func search(completionHandler: @escaping (Bool) -> Void) {
        if nowLoading { return }
        nowLoading = true

        postStartTask()

        service.fetch(whereBookmarkedIs: true) { [weak self] result in
            guard let self = self else { return }
            self.nowLoading = false

            switch result {
            case .success(let restaurants):
                self.success(with: restaurants, by: completionHandler)
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
private extension BookmarkedListViewModel {
    func success(with restaurants: [RestaurantSummary], by completionHandler: @escaping (Bool) -> Void) {
        error = nil
        sourceOfTruth = restaurants
        DispatchQueue.main.async {
            completionHandler(true)
            self.postFinishTask()
        }
    }

    func failure(with error: Error, by completionHandler: @escaping (Bool) -> Void) {
        self.error = error
        DispatchQueue.main.async {
            completionHandler(false)
        }
    }
}
