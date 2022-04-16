//
//  RestaurantCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

final class RestaurantCoordinator: Coordinatorable {
    private unowned var navigationController: UINavigationController!
    private(set) var children = [Coordinatorable]()
    weak var parent: ParentCoordinator?

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let model = parent?.model else {
            return
        }
        let nextCoordinator = MapRoutingCoordinator(on: navigationController)
        nextCoordinator.parent = self
        children = [nextCoordinator]

        let viewModel = RestaurantDetailViewModel(under: RestaurantsBookmarkService.shared, with: model)
        let nextViewController = RestaurantDetailViewController(with: viewModel, coordinator: nextCoordinator)
        navigationController.pushViewController(nextViewController, animated: false)
    }
}

extension RestaurantCoordinator: ParentCoordinator {
    var model: RestaurantSummary? {
        return parent?.model
    }
}
