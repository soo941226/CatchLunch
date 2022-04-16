//
//  RestaurantsViewDelegate.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class RestaurantsViewDelegate: NSObject, UITableViewDelegate {
    private weak var container: RestaurantsViewModelAdopter?
    private weak var imageViewModel: ImageViewModel?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        container?.select()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? RestaurantsViewCell, let mainFoodName = cell.mainFood {
            cell.image = imageViewModel?.placeHolder

            imageViewModel?.search(about: mainFoodName) { [weak self] isSuccess in
                if isSuccess, indexPath == tableView.indexPath(for: cell) {
                    cell.image = self?.imageViewModel?[mainFoodName]
                }
            }
        }
        prefetchRestaurants(on: tableView, with: indexPath)
    }

    func container(is container: RestaurantsViewModelAdopter) {
        self.container = container
    }

    private func prefetchRestaurants(on tableView: UITableView, with indexPath: IndexPath) {
        if tableView.numberOfRows(inSection: .zero) - 2 == indexPath.row {
            container?.requestNextItems()
        }
    }
}

// MARK: - Facade
extension RestaurantsViewDelegate {
    func configure(imageViewModel: ImageViewModel) {
        self.imageViewModel = imageViewModel
    }
}
