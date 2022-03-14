//
//  RestaurantCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

protocol RestaurantCoordinatorDelegate: AnyObject {
    var model: RestaurantSummary? { get }
}

final class RestaurantCoordinator: Coordiantorable {
    private unowned var navigationController: UINavigationController!
    private(set) var childCoodinator = [Coordiantorable]()
    weak var delegate: RestaurantCoordinatorDelegate?

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let model = delegate?.model else {
            return
        }

        let viewModel = RestaurantsBookmarkViewModel(under: RestaurantsBookmarkService())
        let nextViewController = DetailViewController(with: viewModel)
        nextViewController.configure(with: model)
        navigationController.pushViewController(nextViewController, animated: false)
    }
}
