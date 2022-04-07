//
//  MapRoutingCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/31.
//

import UIKit

final class MapRoutingCoordinator: Coordinatorable {
    private unowned var navigationController: UINavigationController!
    private(set) var children = [Coordinatorable]()

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let targetViewModel = MapRouteViewModel()
        let targetViewController = MapRoutingViewController(viewModel: targetViewModel)
        navigationController.pushViewController(targetViewController, animated: false)
    }
}
