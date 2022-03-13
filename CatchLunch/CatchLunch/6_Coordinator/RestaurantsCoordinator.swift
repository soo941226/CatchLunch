//
//  RestaurantsCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

final class RestaurantsCoordinator: Coordiantorable {
    private unowned var navigationController: UINavigationController!

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let mainViewController = navigationController.topViewController as? RestaurantsViewModelContainer else {
            return
        }
        guard let model = mainViewController.selectedModel else {
            return
        }

        let viewModel = RestaurantsBookmarkViewModel(under: RestaurantsBookmarkService())
        let nextViewController = DetailViewController(with: viewModel)
        nextViewController.configure(with: model)
        navigationController.pushViewController(nextViewController, animated: false)
    }

    func next() {

    }
}
