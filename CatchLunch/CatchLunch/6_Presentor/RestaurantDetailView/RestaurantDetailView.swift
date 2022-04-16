//
//  RestaurantDetailView.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

final class RestaurantDetailView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let labelStackView = UIStackView()
    private let mainFoodsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        label.accessibilityLabel =  "주메뉴: "
        return label
    }()
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        label.accessibilityLabel =  "전화번호: "
        return label
    }()
    private let roadAddressLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        label.accessibilityLabel = "도로명주소: "
        return label
    }()
    private let locationAddressLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        label.accessibilityLabel = "지번주소: "
        return label
    }()

    private let viewSpacing: CGFloat = 1.0

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabelContainer()
        setUpSubviews()
    }

    private func setUpLabelContainer() {
        labelStackView.isLayoutMarginsRelativeArrangement = true
        labelStackView.directionalLayoutMargins = .init(dx: .headInset, dy: .zero)
        labelStackView
            .addArrangedSubviews(
                mainFoodsLabel, phoneNumberLabel,
                roadAddressLabel, locationAddressLabel
            )
            .configure(axis: .vertical, distribution: .fillEqually, alignment: .fill)
    }

    private func setUpSubviews() {
        let safeArea = safeAreaLayoutGuide
        let outerStackView = UIStackView()

        outerStackView
            .addArrangedSubviews(imageView, labelStackView)
            .configure(axis: .vertical, distribution: .fillEqually, alignment: .fill)
            .insert(into: self)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(lessThanOrEqualToConstant: .heightLimitOfImage),
            outerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            outerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - Facade
extension RestaurantDetailView {
    func configure(with summary: RestaurantSummary) {
        mainFoodsLabel.text = summary.descriptionOfMainFoodNames?
            .prepended(mainFoodsLabel.accessibilityLabel)
        phoneNumberLabel.text = summary.phoneNumber?
            .prepended(phoneNumberLabel.accessibilityLabel)
        roadAddressLabel.text = summary.roadNameAddress?
            .prepended(roadAddressLabel.accessibilityLabel)
        locationAddressLabel.text = summary.locationNameAddress?
            .prepended(locationAddressLabel.accessibilityLabel)

        mainFoodsLabel.accessibilityValue = summary.descriptionOfMainFoodNames
        phoneNumberLabel.accessibilityValue = summary.phoneNumber
        roadAddressLabel.accessibilityValue = summary.roadNameAddress
        locationAddressLabel.accessibilityValue = summary.locationNameAddress
    }
}
