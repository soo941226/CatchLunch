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
    }

    func start() {
        guard let model = parent?.model else {
            return
        }

        let viewModel = RestaurantDetailViewModel(under: RestaurantsBookmarkService.shared, with: model)
        let nextViewController = RestaurantDetailViewController(with: viewModel)
        navigationController.pushViewController(nextViewController, animated: false)
    }
}
