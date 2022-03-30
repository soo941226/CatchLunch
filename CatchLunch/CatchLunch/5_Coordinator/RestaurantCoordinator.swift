//
//  RestaurantCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

final class RestaurantCoordinator: Coordinatorable {
    private unowned var navigationController: UINavigationController!
    private(set) var childCoodinator = [Coordinatorable]()
    weak var parent: ParentCoordinator?

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
        let nextCoordinator = RoutingCoordinator(on: navigationController)
        childCoodinator.append(nextCoordinator)
    }

    func start() {
        guard let model = parent?.model,
            let nextCoordinator = childCoodinator.first else {
            return
        }

        let viewModel = RestaurantDetailViewModel(under: RestaurantsBookmarkService.shared, with: model)
        let nextViewController = RestaurantDetailViewController(with: viewModel, coordinator: nextCoordinator)
        navigationController.pushViewController(nextViewController, animated: false)
    }
}
