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
    private let imageSearchViewModel = ImageViewModel(service: NaverImageSearcher())
    private let imagePlaceHolder = UIImage(systemName: "fork.knife.circle")!
    private var asset = [RestaurantSummary]()
    private var nowLoading = false

    private(set) var error: Error?

    init(service: Service) {
        self.service = service
    }
}

// MARK: - Facade
extension BookmarkedListViewModel: Notifier {
    var count: Int {
        return asset.count
    }

    subscript(_ index: Int) -> RestaurantInformation? {
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
            asset = []
            postFinishTask()
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
            DispatchQueue.main.async {
                completionHandler(true)
                self?.postFinishTask()
            }
        }
    }
}
