//
//  ConfigurationCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/21.
//

import UIKit

final class ConfigurationCoordinator: Coordiantorable {
    private unowned var navigationController: UINavigationController!
    private(set) var childCoodinator = [Coordiantorable]()

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = CopyRightViewController()
        navigationController.pushViewController(controller, animated: false)
    }
}
