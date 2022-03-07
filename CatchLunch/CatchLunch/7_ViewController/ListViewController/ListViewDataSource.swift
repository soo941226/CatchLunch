//
//  ListViewDataSource.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class RestaurantDataSource: NSObject, UITableViewDataSource {
    private var managingData = [(restaurant: RestaurantInformation, image: UIImage)]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managingData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListViewCell.identifier,
            for: indexPath
        ) as? ListViewCell else {
            return ListViewCell()
        }

        cell.configure(with: managingData[indexPath.row])
        return cell
    }

    func append(_ restaurants: [(restaurant: RestaurantInformation, image: UIImage)]) {
        self.managingData += restaurants
    }
}
