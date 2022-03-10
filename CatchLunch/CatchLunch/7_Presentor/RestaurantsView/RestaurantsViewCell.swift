//
//  RestaurantsViewCell.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

final class RestaurantsViewCell: UITableViewCell {
    static let identifier = #fileID

    private let contentsStackView = UIStackView()
    private let labelStackView = UIStackView()
    private let foodImageView = UIImageView()
    private let titleLabel = UILabel()
    private let locationLabel = UILabel()
    private let foodNamesLabel = UILabel()

    private let labelSpacing: CGFloat = 8.0
    private let imageSpacing: CGFloat = 8.0
    private let widthPercentageAboutImageView: CGFloat = 0.3

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
        setUpConstraints()
    }

    private func setUpSubviews() {
        labelStackView
            .configure(
                axis: .vertical, distribution: .fillProportionally,
                alignment: .fill, spacing: labelSpacing
            )
            .addArrangedSubviews(titleLabel, locationLabel, foodNamesLabel)

        contentsStackView
            .configure(
                axis: .horizontal, distribution: .fillProportionally,
                alignment: .fill, spacing: imageSpacing
            )
            .addArrangedSubviews(foodImageView, labelStackView)

        contentView.addSubview(contentsStackView)
    }

    private func setUpConstraints() {
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            foodImageView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: widthPercentageAboutImageView
            ),
            contentsStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

// MARK: - Facade
extension RestaurantsViewCell {
    func configure(with data: RestaurantSummary) {
        let restaurant = data.information
        let image = data.image

        titleLabel.text = restaurant.restaurantName
        locationLabel.text = restaurant.cityName
        foodNamesLabel.text = restaurant.descriptionOfMainFoodNames
        foodImageView.image = image
    }
}
