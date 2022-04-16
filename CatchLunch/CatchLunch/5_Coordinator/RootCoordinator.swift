//
//  RootCoordinator.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class RootCoordinator: Coordinatorable {
    private unowned var navigationController: UINavigationController!
    private(set) var children = [Coordinatorable]()

    private var observer: NSKeyValueObservation?

    init(on navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let imageViewModel = ImageViewModel(service: NaverImageSearcher(), DaumImageSearcher())
        let searchBarController = SearchViewController(imageViewModel: imageViewModel)
        var container = [UIViewController]()

        setUpRestaurantView(into: &container, with: imageViewModel)
        setUpParagonRestaurantView(into: &container, with: imageViewModel)
        setUpBookmarkView(into: &container, with: imageViewModel)
        setUpConfigurationView(into: &container)

        searchBarController.title = "맛집"
        searchBarController.setViewControllers(container, animated: false)
        navigationController.pushViewController(searchBarController, animated: false)
        setObserverToChangeTitle(on: searchBarController)
    }
}

extension RootCoordinator: ParentCoordinator {
    var model: RestaurantSummary? {
        guard let searchBarController = navigationController.children.first as? SearchViewController,
              let viewController = searchBarController.selectedViewController else {
            return nil
        }

        guard let restaurantsViewController = viewController as? RestaurantsViewModelContainer else {
            return nil
        }

        return restaurantsViewController.selectedModel
    }
}

private extension RootCoordinator {
    func setUpRestaurantView(
        into container: inout [UIViewController],
        with imageViewModel: ImageViewModel
    ) {
        let coordinator = RestaurantCoordinator(on: navigationController)
        let viewModel = RestaurantsViewModel(service: GyeonggiRestaurantsSearcher())
        let controller = RestaurantsViewController(with: viewModel, under: coordinator)
        coordinator.parent = self
        children.append(coordinator)

        let itemImage = UIImage.yum.withRenderingMode(.alwaysOriginal)

        controller.tabBarItem = .init(title: "맛집", image: itemImage, selectedImage: nil)
        controller.tabBarItem.imageInsets = .init(dx: .headInset, dy: .headInset)
        container.append(controller)
    }

    func setUpParagonRestaurantView(
        into container: inout [UIViewController],
        with imageViewModel: ImageViewModel
    ) {
        let coordinator = RestaurantCoordinator(on: navigationController)
        let viewModel = RestaurantsViewModel(service: GyeonggiParagonRestaurantSearcher())
        let controller = RestaurantsViewController(with: viewModel, under: coordinator)
        coordinator.parent = self
        children.append(coordinator)

        let itemImage = UIImage.cook.withRenderingMode(.alwaysOriginal)

        controller.tabBarItem = .init(title: "모범식당", image: itemImage, selectedImage: nil)
        controller.tabBarItem.imageInsets = .init(dx: .headInset, dy: .headInset)
        container.append(controller)
    }

    func setUpBookmarkView(
        into container: inout [UIViewController],
        with imageViewModel: ImageViewModel
    ) {
        let coordinator = RestaurantCoordinator(on: navigationController)
        let viewModel = BookmarkedListViewModel(
            service: RestaurantsBookmarkService.shared,
            imageViewModel: imageViewModel
        )
        let controller = BookmarkdListViewController(viewModel: viewModel, under: coordinator)
        coordinator.parent = self
        children.append(coordinator)

        let itemImage = UIImage.starFill.filled(with: .systemYellow)

        controller.tabBarItem = .init(title: "즐겨찾기", image: itemImage, selectedImage: nil)
        container.append(controller)
    }

    func setUpConfigurationView(into container: inout [UIViewController]) {
        let coordinator = ConfigurationCoordinator(on: navigationController)
        let controller = ConfigurationViewController(under: coordinator)
        coordinator.viewController(is: controller)
        children.append(coordinator)

        let itemImage = UIImage.gearshapeFill.filled(with: .lightGray)
        let selectedImage = UIImage.gearshapeFill.filled(with: .systemBlue)
        controller.tabBarItem = .init(title: "설정", image: itemImage, selectedImage: selectedImage)
        container.append(controller)
    }

    func setObserverToChangeTitle(on controller: SearchViewController) {
        observer = controller.observe(
            \.selectedItemIndex,
             options: .new,
             changeHandler: { [weak self] _, value in
                 guard let navigationController = self?.navigationController,
                       let searchBarController = navigationController.children.first as? SearchViewController,
                       let controllerIndex = value.newValue else {
                     return
                 }

                 switch controllerIndex {
                 case 1:
                     searchBarController.title = "모범식당"
                 case 2:
                     searchBarController.title = "즐겨찾기"
                 case 3:
                     searchBarController.title = "설정"
                 default:
                     searchBarController.title = "맛집"
                 }
             }
        )
    }
}
