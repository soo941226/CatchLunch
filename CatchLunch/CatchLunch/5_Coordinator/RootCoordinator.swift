//
//  RootCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class RootCoordinator: Coordiantorable {
    private unowned var navigationController: UINavigationController!
    private(set) var childCoodinator = [Coordiantorable]()

    private let searchBarController = SearchViewController()
    private var observer: NSKeyValueObservation?

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        var container = [UIViewController]()

        setUpRestaurantView(into: &container)
        setUpParagonRestaurantView(into: &container)
        setUpBookmarkView(into: &container)
        setUpConfigurationView(into: &container)

        searchBarController.title = "맛집"
        searchBarController.setViewControllers(container, animated: false)
        navigationController.pushViewController(searchBarController, animated: false)
        addObserverToChangeTitle(on: searchBarController)
    }

    private func setUpRestaurantView(into container: inout [UIViewController]) {
        let coordinator = RestaurantCoordinator(on: navigationController)
        let viewModel = RestaurantsViewModel(service: GyeonggiRestaurantsSearcher())
        let controller = RestaurantsViewController(with: viewModel, under: coordinator)
        coordinator.parent = self
        childCoodinator.append(coordinator)

        let itemImage = UIImage(named: "yum")?.withRenderingMode(.alwaysOriginal)
        let insetAmount = 6.0

        controller.tabBarItem = .init(title: "맛집", image: itemImage, selectedImage: nil)
        controller.tabBarItem.imageInsets = .init(dx: insetAmount, dy: insetAmount)
        container.append(controller)
    }

    private func setUpParagonRestaurantView(into container: inout [UIViewController]) {
        let coordinator = RestaurantCoordinator(on: navigationController)
        let viewModel = RestaurantsViewModel(service: GyeonggiParagonRestaurantSearcher())
        let controller = RestaurantsViewController(with: viewModel, under: coordinator)
        coordinator.parent = self
        childCoodinator.append(coordinator)

        let itemImage = UIImage(named: "cook")?.withRenderingMode(.alwaysOriginal)
        let insetAmount = 6.0

        controller.tabBarItem = .init(title: "모범식당", image: itemImage, selectedImage: nil)
        controller.tabBarItem.imageInsets = .init(dx: insetAmount, dy: insetAmount)
        container.append(controller)
    }

    private func setUpBookmarkView(into container: inout [UIViewController]) {
        let coordinator = RestaurantCoordinator(on: navigationController)
        let viewModel = BookmarkedListViewModel(service: RestaurantsBookmarkService.shared)
        let controller = BookmarkdListViewController(viewModel: viewModel, under: coordinator)
        coordinator.parent = self
        childCoodinator.append(coordinator)

        let itemImage = UIImage(systemName: "star.fill")?.filled(with: .systemYellow)

        controller.tabBarItem = .init(title: "즐겨찾기", image: itemImage, selectedImage: nil)
        container.append(controller)
    }

    private func setUpConfigurationView(into container: inout [UIViewController]) {
        let coordinator = ConfigurationCoordinator(on: navigationController)
        let controller = ConfigurationViewController(under: coordinator)
        childCoodinator.append(coordinator)

        let itemImage = UIImage(systemName: "gearshape.fill")?.filled(with: .lightGray)
        let selectedImage = UIImage(systemName: "gearshape.fill")?.filled(with: .systemBlue)
        controller.tabBarItem = .init(title: "설정", image: itemImage, selectedImage: selectedImage)
        container.append(controller)
    }

    private func addObserverToChangeTitle(on controller: SearchViewController) {
        NotificationCenter.default.post(name: .finishTask, object: nil)

        observer = controller.observe(\.selectedItemIndex, options: .new) { [weak self] _, value in
            guard let controllerIndex = value.newValue else {
                return
            }

            switch controllerIndex {
            case 1:
                self?.searchBarController.title = "모범식당"
            case 2:
                self?.searchBarController.title = "즐겨찾기"
            case 3:
                self?.searchBarController.title = "설정"
            default:
                self?.searchBarController.title = "맛집"
            }
        }
    }
}

extension RootCoordinator: ParentCoordinator {
    var model: RestaurantInformation? {
        guard let viewController = searchBarController.selectedViewController else {
            return nil
        }

        guard let restaurantsViewController = viewController as? RestaurantsViewModelContainer else {
            return nil
        }

        return restaurantsViewController.selectedModel
    }
}
