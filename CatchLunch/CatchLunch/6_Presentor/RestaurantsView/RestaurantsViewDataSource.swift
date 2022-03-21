//
//  RestaurantsViewDataSource.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class RestaurantsViewDataSource<ViewModel: JustSearchViewModelable>: NSObject, UITableViewDataSource
where ViewModel.Item == RestaurantSummary {
    private unowned var viewModel: ViewModel!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RestaurantsViewCell.identifier,
            for: indexPath
        ) as? RestaurantsViewCell else {
            return RestaurantsViewCell()
        }

        cell.accessoryType = .disclosureIndicator
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }

    func viewModel(is viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
