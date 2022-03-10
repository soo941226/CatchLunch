//
//  DetailInformationView.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit
import MapKit

final class DetailInformationView: UIView {
    private let imageView = UIImageView()

    private let labelContainer = UIStackView()

    private let nameSectionContainer = UIStackView()
    private let cityNameLabel = UILabel()
    private let restaurantNameLabel = UILabel()
    private let mainFoodsLabel = UILabel()

    private let phoneNumberLabel = UILabel()
    private let roadAddressLabel = UILabel()
    private let locationAddressLabel = UILabel()

    private let mapView = MKMapView()

    private let viewSpacing: CGFloat = 1.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpImageView()
        setUpContainers()
        setUpMapView()
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
                alignment: .leading, spacing: viewSpacing
            )
            .addArrangedSubviews(cityNameLabel, restaurantNameLabel)

        labelContainer
            .configure(
                axis: .vertical, distribution: .fillProportionally,
                alignment: .fill, spacing: viewSpacing
            )
            .addArrangedSubviews(
                nameSectionContainer, mainFoodsLabel, phoneNumberLabel,
                roadAddressLabel, locationAddressLabel
            )

        addSubview(labelContainer)
    }

    private func setUpMapView() {
        addSubview(mapView)
    }

    private func stylingStackViews() {
        labelContainer.addBorder(color: .lightGray)
        nameSectionContainer.addBorder(color: .lightGray)
    }

    private func setUpConstraints() {
        let safeArea = safeAreaLayoutGuide

        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            labelContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            labelContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            labelContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: labelContainer.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 200.0)
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

        if let longitude = summary.information.longitude,
           let latitude = summary.information.latitude {

            mapView.cameraZoomRange = .init(maxCenterCoordinateDistance: 500.0)

            mapView.addAnnotation(TempAnnotation(latitdue: latitude, longitude: longitude))
            mapView.centerCoordinate = .init(latitude: latitude, longitude: longitude)
        }
    }
}

final class TempAnnotation: NSObject, MKAnnotation {
    private(set) var coordinate: CLLocationCoordinate2D

    init(latitdue: CGFloat, longitude: CGFloat) {
        self.coordinate = .init(latitude: latitdue, longitude: longitude)
    }
}
