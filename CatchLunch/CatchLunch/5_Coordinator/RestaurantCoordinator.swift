//
//  RestaurantCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit
final class RestaurantCoordinator: Coordiantorable {
    private unowned var navigationController: UINavigationController!
    private(set) var childCoodinator = [Coordiantorable]()
    weak var parent: ParentCoordinator?

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let model = parent?.model else {
            return
        }

        let viewModel = RestaurantsBookmarkViewModel(under: RestaurantsBookmarkService.shared)
        let nextViewController = DetailViewController(with: viewModel)
        nextViewController.configure(with: model)
        navigationController.pushViewController(nextViewController, animated: false)
    }
}
