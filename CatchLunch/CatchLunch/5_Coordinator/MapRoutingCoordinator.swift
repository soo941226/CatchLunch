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
    weak var parent: ParentCoordinator?

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let restaurant = parent?.model?.summary,
              let latitude = restaurant.latitude,
              let longitude = restaurant.longitude else {
            return
        }

        let targetViewModel = MapRouteViewModel(endPoint: .init(latitude: latitude, longitude: longitude))
        let targetViewController = MapRoutingViewController(viewModel: targetViewModel)
        navigationController.pushViewController(targetViewController, animated: false)
    }
}
