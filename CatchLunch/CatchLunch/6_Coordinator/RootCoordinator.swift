//
//  RootCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class RootCoordinator: Coordiantorable {
    private unowned var navigationController: UINavigationController!
    private var childCoordinators = [Coordiantorable]()

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators.append(RestaurantsCoordinator(on: navigationController))
    }

    func start() {
        let viewModel = RestaurantsViewModel(service: GyeonggiRestaurantsSearcher())
        let mainViewController = RestaurantsViewController(with: viewModel, under: self)
        navigationController.pushViewController(mainViewController, animated: false)
    }

    func next() {
        childCoordinators.first?.start()
    }
}
