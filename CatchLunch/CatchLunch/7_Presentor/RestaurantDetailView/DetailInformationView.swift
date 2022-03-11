//
//  DetailInformationView.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit
import MapKit

final class DetailInformationView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let labelContainer = UIStackView()
    private let mainFoodsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let roadAddressLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let locationAddressLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.cameraZoomRange = .init(maxCenterCoordinateDistance: 500.0)
        return mapView
    }()

    private let viewSpacing: CGFloat = 1.0

    private let foodNamePrefix = "주메뉴: "
    private let phoneNumberPrefix = "전화번호: "
    private let roadAddressPrefix = "도로명주소: "
    private let locationAddressPrefix = "지번주소: "

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabelContainer()
        setUpSubviews()
    }

    private func setUpLabelContainer() {
        labelContainer.isLayoutMarginsRelativeArrangement = true
        labelContainer.directionalLayoutMargins = .init(top: .zero, leading: 10.0, bottom: .zero, trailing: 10.0)
        labelContainer
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
            .addArrangedSubviews(imageView, labelContainer, mapView)
            .configure(axis: .vertical, distribution: .fillEqually, alignment: .fill)
            .insert(into: self)

        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            outerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - Facade
extension DetailInformationView {
    func configure(with summary: RestaurantSummary) {
        let (data, image) = summary
        imageView.image = image

        mainFoodsLabel.text = data.descriptionOfMainFoodNames?.prepended(foodNamePrefix)
        phoneNumberLabel.text = data.phoneNumber?.prepended(phoneNumberPrefix)
        roadAddressLabel.text = data.roadNameAddress?.prepended(roadAddressPrefix)
        locationAddressLabel.text = data.locationNameAddress?.prepended(locationAddressPrefix)

        guard let longitude = summary.information.longitude,
           let latitude = summary.information.latitude else {
               return
           }

        mapView.addAnnotation(MapMarker(latitdue: latitude, longitude: longitude))
        mapView.centerCoordinate = .init(latitude: latitude, longitude: longitude)
    }
}
