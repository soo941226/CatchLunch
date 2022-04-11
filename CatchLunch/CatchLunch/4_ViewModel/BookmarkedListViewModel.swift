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
    private let imageViewModel: ImageViewModel
    private let imagePlaceHolder = UIImage.forkKnifeCircle
    private var sourceOfTruth = [RestaurantSummary]()
    private var nowLoading = false

    private(set) var error: Error?

    init(service: Service, imageViewModel: ImageViewModel) {
        self.service = service
        self.imageViewModel = imageViewModel
    }
}

// MARK: - Facade
extension BookmarkedListViewModel: Notifier {
    var count: Int {
        return sourceOfTruth.count
    }

    subscript(_ index: Int) -> RestaurantInformation? {
        guard sourceOfTruth.indices ~= index else {
            return nil
        }

        let image = sourceOfTruth[index].mainFoodNames?.first
            .flatMap({ name in
                imageViewModel[name]
            })

        return (sourceOfTruth[index], image ?? imagePlaceHolder)
    }

    func fetch(completionHandler: @escaping (Bool) -> Void) {
        if nowLoading { return }
        nowLoading = true

        postStartTask()

        service.fetch(whereBookmarkedIs: true) { [weak self] result in
            self?.nowLoading = false

            switch result {
            case .success(let restaurants):
                self?.fetchImagesToFinish(from: restaurants, with: completionHandler)
            case .failure(let error):
                self?.error = error
                DispatchQueue.main.async {
                    completionHandler(false)
                }
            }
        }
    }

    func willDisappear() {
        postFinishTask()
    }

    private func fetchImagesToFinish(
        from restaurants: [RestaurantSummary],
        with completionHandler: @escaping (Bool) -> Void
    ) {
        guard restaurants.count > .zero else {
            sourceOfTruth = []
            postFinishTask()
            DispatchQueue.main.async {
                completionHandler(true)
            }
            return
        }

        let dispatchGroup = DispatchGroup()

        restaurants.forEach { model in
            dispatchGroup.enter()
            let foodName = model.mainFoodNames?.first ?? ""
            imageViewModel.fetch(about: foodName) { _ in
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.error = nil
            self?.sourceOfTruth = restaurants
            DispatchQueue.main.async {
                completionHandler(true)
                self?.postFinishTask()
            }
        }
    }
}
