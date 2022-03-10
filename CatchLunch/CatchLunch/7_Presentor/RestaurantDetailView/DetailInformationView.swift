//
//  DetailInformationView.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

final class DetailInformationView: UIView {
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let cityNameLabel = UILabel()
    private let restaurantNameLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    private let roadAddressLabel = UILabel()
    private let locationAddressLabel = UILabel()
    private let mainFoodsLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        stackView
            .configure(
                axis: .vertical, distribution: .fillProportionally,
                alignment: .leading, spacing: 8.0)
            .addArrangedSubviews(
                imageView, cityNameLabel, restaurantNameLabel, phoneNumberLabel,
                roadAddressLabel, locationAddressLabel, mainFoodsLabel
            )

        let safeArea = safeAreaLayoutGuide

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with summary: RestaurantSummary) {
        imageView.image = summary.image
        cityNameLabel.text = summary.information.cityName
        restaurantNameLabel.text = summary.information.restaurantName
        phoneNumberLabel.text = summary.information.phoneNumber
        roadAddressLabel.text = summary.information.roadNameAddress
        locationAddressLabel.text = summary.information.locationNameAddress
        mainFoodsLabel.text = summary.information.descriptionOfMainFoodNames
    }
}
