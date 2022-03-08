//
//  RestaurantsCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

final class RestaurantsCoordinator: Coordiantorable {
    private unowned var navigationController: UINavigationController!

    private(set) var childCoordinators = [Coordiantorable]()

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.pushViewController(DetailViewController(), animated: true)
    }

    func next() {

    }
}
