//
//  ListViewCell.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class ListViewCell: UITableViewCell {
    static let identifier = #fileID

    private let foodImageView = UIImageView()
    private let titleLabel = UILabel()
    private let locationLabel = UILabel()
    private let foodNamesLabel = UILabel()

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
    }

    private func setUpSubviews() {
        let innerStackView = UIStackView
            .init(
                arrangedSubviews: [titleLabel, locationLabel, foodNamesLabel]
            )
            .configure(
                axis: .vertical, distribution: .fillProportionally,
                alignment: .fill, spacing: 4
            )

        let outerStackView = UIStackView
            .init(
                arrangedSubviews: [foodImageView, innerStackView]
            )
            .configure(
                axis: .horizontal, distribution: .fillProportionally,
                alignment: .fill, spacing: 8
            )

        contentView.addSubview(outerStackView)

        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func configure(with data: (restaurant: RestaurantInformation, image: UIImage)) {
        let restaurant = data.restaurant
        let image = data.image
        var foodNames = restaurant.mainFoodNames?.reduce("", { partialResult, name in
            return partialResult + ", " + name
        })
        foodNames?.removeFirst(2)

        titleLabel.text = restaurant.restaurantName
        locationLabel.text = restaurant.cityName
        foodNamesLabel.text = foodNames
        foodImageView.image = image
    }
}
