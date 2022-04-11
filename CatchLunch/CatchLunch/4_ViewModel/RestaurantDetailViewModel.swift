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

    private(set) var information: RestaurantInformation
    private(set) var error: Error?

    private let buttonImage = (
        on: UIImage.starFill,
        off: UIImage.star
    )
    var button: UIImage? {
        if information.summary.isBookmarked {
            return buttonImage.on
        } else {
            return buttonImage.off
        }
    }

    init(under service: Service, with element: RestaurantInformation) {
        self.service = service
        self.information = element
    }

    func check(then completionHandler: @escaping () -> Void) {
        service.checkBookmark(about: information.summary) { [weak self] isBookmarked in
            if isBookmarked != self?.information.summary.isBookmarked {
                self?.information.summary.toggledBookmark()
            }

            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }

    func toggle(then completionHandler: @escaping () -> Void) {
        if nowUpdate { return }
        nowUpdate = true
        service.toggleBookmark(about: information.summary) { [weak self] error in
            if let error = error {
                self?.error = error
            }
            self?.information.summary.toggledBookmark()
            self?.nowUpdate = false

            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
}
