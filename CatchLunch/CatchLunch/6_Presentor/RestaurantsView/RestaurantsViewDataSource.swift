//
//  RestaurantsViewDataSource.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class RestaurantsViewDataSource: NSObject, UITableViewDataSource {
    private var managingData = [RestaurantSummary]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managingData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RestaurantsViewCell.identifier,
            for: indexPath
        ) as? RestaurantsViewCell else {
            return RestaurantsViewCell()
        }

        cell.accessoryType = .disclosureIndicator
        cell.configure(with: managingData[indexPath.row])
        return cell
    }

    func append(_ restaurants: [RestaurantSummary]) {
        self.managingData += restaurants
    }
}
