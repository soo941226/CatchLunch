//
//  ConfigurationCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/21.
//

import UIKit

final class ConfigurationCoordinator: Coordinatorable {
    private unowned var navigationController: UINavigationController!
    private unowned var viewController: ConfigurationViewController!
    private(set) var childCoodinator = [Coordinatorable]()

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func take(_ viewController: ConfigurationViewController) {
        self.viewController = viewController
    }

    func start() {
        switch viewController.selected {
        case .caution:
            let controller = CautionViewController()
            navigationController.pushViewController(controller, animated: false)
        case .copyright:
            let controller = CopyRightViewController()
            navigationController.pushViewController(controller, animated: false)
        }
    }
}
