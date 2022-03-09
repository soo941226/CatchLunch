//
//  RestaurantsViewDelegate.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class RestaurantsViewDelegate: NSObject, UITableViewDelegate {
    private weak var container: RestaurantsViewModelContainer?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        container?.select()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        prefetch(on: tableView, with: indexPath)
    }

    func setUpContainer(with container: RestaurantsViewModelContainer) {
        self.container = container
    }

    private func prefetch(on tableView: UITableView, with indexPath: IndexPath) {
        if tableView.numberOfRows(inSection: .zero) - 2 == indexPath.row {
            container?.requestNextItems()
        }
    }
}
