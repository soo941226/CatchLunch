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
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        return imageView
    }()

    private let labelStackView = UIStackView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        label.isAccessibilityElement = false
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.adjustsFontSizeToFitWidth = true
        label.isAccessibilityElement = false
        return label
    }()
    private let foodNamesLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.adjustsFontSizeToFitWidth = true
        label.isAccessibilityElement = false
        return label
    }()

    private let cellSpacing: CGFloat = 8.0
    private let labelSpacing: CGFloat = 8.0
    private let imageSpacing: CGFloat = 8.0
    private let widthPercentageAboutImageView: CGFloat = 0.3

    private let locationLabelPrefix = "위치: "
    private let foodNamesLabelPrefix = "주메뉴: "

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        isAccessibilityElement = true
        accessibilityTraits = .link
        setUpSubviews()
        setUpConstraints()
    }

    private func setUpSubviews() {
        labelStackView
            .addArrangedSubviews(titleLabel, locationLabel, foodNamesLabel)
            .configure(
                axis: .vertical, distribution: .fillProportionally,
                alignment: .fill, spacing: labelSpacing
            )

        contentsStackView
            .addArrangedSubviews(foodImageView, labelStackView)
            .configure(
                axis: .horizontal, distribution: .fillProportionally,
                alignment: .fill, spacing: imageSpacing
            )
            .insert(into: contentView)
    }

    private func setUpConstraints() {
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            foodImageView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: widthPercentageAboutImageView
            ),
            contentsStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: cellSpacing
            ),
            contentsStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -cellSpacing
            ),
            contentsStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: cellSpacing
            ),
            contentsStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -cellSpacing
            )
        ])
    }

    private func setUpAccessbilityMessage(with data: RestaurantSummary) {
        let city = data.cityName
        let foods = data.descriptionOfMainFoodNames
        let cityDesciprtion = city?.isEmpty == false ? locationLabelPrefix + city! : ""
        let foodsDescription = foods?.isEmpty == false ? foodNamesLabelPrefix + foods! : ""

        accessibilityLabel = data.restaurantName
        accessibilityValue = cityDesciprtion + ", " + foodsDescription
    }
}

// MARK: - Facade
extension RestaurantsViewCell {
    func configure(with restaurant: RestaurantSummary?) {
        guard let restaurant = restaurant else {
            return
        }

        titleLabel.text = restaurant.restaurantName
        locationLabel.text = restaurant.cityName?.prepended(locationLabelPrefix)
        foodNamesLabel.text = restaurant.descriptionOfMainFoodNames?.prepended(foodNamesLabelPrefix)
        setUpAccessbilityMessage(with: restaurant)
    }
}
