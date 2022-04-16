//
//  RestaurantDetailViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/13.
//

import UIKit

final class RestaurantDetailViewModel<Service: BookmarkService>: BookmarkableViewModel
where Service.Response == RestaurantSummary {
    private let service: Service
    private var nowUpdate = false

    private(set) var element: RestaurantSummary
    private(set) var error: Error?

    private let buttonImage = (
        on: UIImage.starFill,
        off: UIImage.star
    )
    var button: UIImage? {
        if element.isBookmarked {
            return buttonImage.on
        } else {
            return buttonImage.off
        }
    }

    init(under service: Service, with summary: RestaurantSummary) {
        self.service = service
        self.element = summary
    }

    func check(then completionHandler: @escaping () -> Void) {
        service.checkBookmark(about: element) { [weak self] isBookmarked in
            if isBookmarked != self?.element.isBookmarked {
                self?.element.toggledBookmark()
            }

            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }

    func toggle(then completionHandler: @escaping () -> Void) {
        if nowUpdate { return }
        nowUpdate = true
        service.toggleBookmark(about: element) { [weak self] error in
            if let error = error {
                self?.error = error
            }
            self?.element.toggledBookmark()
            self?.nowUpdate = false

            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
}
