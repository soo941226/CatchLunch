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
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60.0)
        ])
        return imageView
    }()

    private let labelContainer = UIStackView()

    private let mainFoodsLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    private let roadAddressLabel = UILabel()
    private let locationAddressLabel = UILabel()

    private let mapView = MKMapView()

    private let viewSpacing: CGFloat = 1.0
    private let temporayCameraRange: CGFloat = 500.0

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpSubviews()
        setUpLabelContainer()
    }

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    private func setUpLabelContainer() {
        labelContainer
            .configure(
                axis: .vertical, distribution: .fill,
                alignment: .fill, spacing: viewSpacing
            )
            .addArrangedSubviews(
                mainFoodsLabel, phoneNumberLabel,
                roadAddressLabel, locationAddressLabel
            )
            .addBorder(color: .darkGray)
    }

    private func setUpSubviews() {
        let safeArea = safeAreaLayoutGuide
        let outerStackView = UIStackView()

        outerStackView
            .insert(into: self)
            .configure(
                axis: .vertical, distribution: .fill,
                alignment: .fill, spacing: viewSpacing
            )
            .addArrangedSubviews(
                imageView, labelContainer, mapView
            )
            .addBorder(color: .lightGray)

        outerStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            outerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            outerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}

// MARK: - Facade
extension DetailInformationView {
    func configure(with summary: RestaurantSummary) {
        imageView.image = summary.image
        phoneNumberLabel.text = summary.information.phoneNumber
        roadAddressLabel.text = summary.information.roadNameAddress
        locationAddressLabel.text = summary.information.locationNameAddress
        mainFoodsLabel.text = summary.information.descriptionOfMainFoodNames

        guard let longitude = summary.information.longitude,
           let latitude = summary.information.latitude else {
               return
           }

        mapView.cameraZoomRange = .init(maxCenterCoordinateDistance: temporayCameraRange)
        mapView.addAnnotation(TempAnnotation(latitdue: latitude, longitude: longitude))
        mapView.centerCoordinate = .init(latitude: latitude, longitude: longitude)
    }
}

final class TempAnnotation: NSObject, MKAnnotation {
    private(set) var coordinate: CLLocationCoordinate2D

    init(latitdue: CGFloat, longitude: CGFloat) {
        self.coordinate = .init(latitude: latitdue, longitude: longitude)
    }
}
