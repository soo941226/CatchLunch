//
//  DetailInformationView.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

final class DetailInformationView: UIScrollView {
    private let imageView = UIImageView()

    private let labelContainer = UIStackView()

    private let nameSectionContainer = UIStackView()
    private let cityNameLabel = UILabel()
    private let restaurantNameLabel = UILabel()
    private let mainFoodsLabel = UILabel()

    private let phoneNumberLabel = UILabel()
    private let roadAddressLabel = UILabel()
    private let locationAddressLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpImageView()
        setUpContainers()
        stylingStackViews()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    private func setUpImageView() {
        addSubview(imageView)
    }

    private func setUpContainers() {
        nameSectionContainer
            .configure(
                axis: .horizontal, distribution: .fillProportionally,
                alignment: .leading, spacing: 1.0
            )
            .addArrangedSubviews(cityNameLabel, restaurantNameLabel)

        labelContainer
            .configure(
                axis: .vertical, distribution: .fillProportionally,
                alignment: .fill, spacing: 1.0
            )
            .addArrangedSubviews(
                nameSectionContainer, mainFoodsLabel, phoneNumberLabel,
                roadAddressLabel, locationAddressLabel
            )

        addSubview(labelContainer)
    }

    private func stylingStackViews() {
        labelContainer.addBorder(color: .lightGray)
        nameSectionContainer.addBorder(color: .lightGray)
    }

    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide

        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            labelContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            labelContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            labelContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}

// MARK: - Facade
extension DetailInformationView {
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
