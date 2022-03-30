//
//  RoutingCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/31.
//

import UIKit

final class RoutingCoordinator: Coordinatorable {
    private unowned var navigationController: UINavigationController!
    private(set) var childCoodinator = [Coordinatorable]()

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        print("야호")
    }
}
