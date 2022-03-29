//
//  MapRoutingService.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/29.
//

import MapKit

@frozen enum MapRoutingError: Error {
    case locationsIsEmpty
    case placemarksIsEmpty
}

final class MapRoutingService: NSObject, Notifier {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()

    override init() {
        super.init()
        setUpManager()
    }

    private func setUpManager() {
        locationManager.delegate = self
    }
}

extension MapRoutingService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        postFinishTaskWithError(message: error.localizedDescription)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first else { return }
        }
    }
}
