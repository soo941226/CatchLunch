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
        let nextCoordinator = MapRoutingCoordinator(on: navigationController)
        children.append(nextCoordinator)
    }

    func start() {
        guard let model = parent?.model,
            let nextCoordinator = children.first else {
            return
        }

        let viewModel = RestaurantDetailViewModel(under: RestaurantsBookmarkService.shared, with: model)
        let nextViewController = RestaurantDetailViewController(with: viewModel, coordinator: nextCoordinator)
        navigationController.pushViewController(nextViewController, animated: false)
    }
}
