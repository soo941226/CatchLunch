//
//  RestaurantsBookmarkViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/13.
//

import UIKit

final class RestaurantsBookmarkViewModel<Service: BookmarkService>: BookmarkViewModel
where Service.Response == RestaurantSummary {

    private let service: Service
    private var nowUpdate = false

    private(set) var error: Error?
    private(set) var button = (
        on: UIImage(systemName: "star.fill"),
        off: UIImage(systemName: "star")
    )

    init(under service: Service) {
        self.service = service
    }

    func check(
        about restaurant: RestaurantSummary,
        then completionHandler: @escaping (_ isBookmarked: Bool) -> Void
    ) {
        service.checkBookmark(about: restaurant) { isBookmarked in
            completionHandler(isBookmarked)
        }
    }

    func toggle(about restaurant: RestaurantSummary) {
        if nowUpdate { return }
        nowUpdate = true
        service.toggleBookmark(about: restaurant) { [weak self] error in
            if let error = error {
                self?.error = error
            }
            self?.nowUpdate = false
        }
    }
}
