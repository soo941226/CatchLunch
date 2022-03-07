//
//  RestaurantsViewCell.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class RestaurantsViewCell: UITableViewCell {
    static let identifier = #fileID

    private let outerStackView = UIStackView()
    private let innerStackView = UIStackView()
    private let foodImageView = UIImageView()
    private let titleLabel = UILabel()
    private let locationLabel = UILabel()
    private let foodNamesLabel = UILabel()

    private let labelSpacing: CGFloat = 8.0
    private let imageSpacing: CGFloat = 8.0
    private let imageViewWidthPercentageAtCell: CGFloat = 0.3

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
    }

    private func setUpSubviews() {
        innerStackView
            .configure(
                axis: .vertical, distribution: .fillProportionally,
                alignment: .fill, spacing: labelSpacing
            )
            .addArrangedSubviews(titleLabel, locationLabel, foodNamesLabel)

        outerStackView
            .configure(
                axis: .horizontal, distribution: .fillProportionally,
                alignment: .fill, spacing: imageSpacing
            )
            .addArrangedSubviews(foodImageView, innerStackView)

        contentView.addSubview(outerStackView)

        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodImageView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: imageViewWidthPercentageAtCell
            ),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func configure(with data: (restaurant: RestaurantInformation, image: UIImage)) {
        let restaurant = data.restaurant
        let image = data.image

        titleLabel.text = restaurant.restaurantName
        locationLabel.text = restaurant.cityName
        foodNamesLabel.text = restaurant.descriptionOfMainFoodNames
        foodImageView.image = image
    }
}
