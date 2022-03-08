//
//  RootCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class RootCoordinator: Coordiantorable {
    private unowned var navigationController: UINavigationController!
    private(set) var childCoordinators = [Coordiantorable]()

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators.append(RestaurantsCoordinator(on: navigationController))
    }

    func start() {
        let viewModel = RestaurantsViewModel(service: GyeonggiRestaurantsSearcher())
        let mainViewController = RestaurantsViewController(
            with: viewModel, under: self
        )
        navigationController.pushViewController(mainViewController, animated: false)
        navigationController.navigationBar.backgroundColor = .systemBackground
        navigationController.navigationBar.topItem?.titleView?.tintColor = .label
        navigationController.navigationBar.topItem?.title = "맛집 찾아보기"
    }

    func next() {
        guard let mainViewController = navigationController.topViewController as? RestaurantsViewModelContainer else {
            return
        }
        guard let model = mainViewController.selectedModel else {
            return
        }
        print(model)
        childCoordinators.first?.start()
    }
}
