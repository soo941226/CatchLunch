//
//  LocationService.swift
//  CatchLunch
//
//  Created by kjs on 2022/04/08.
//

import MapKit

final class LocationService: NSObject {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var completionHandler: ((Result<MKMapItem, Error>) -> Void)?

    override init() {
        super.init()
        setUpManager()
    }

    func setUp(completionHandler: @escaping (Result<MKMapItem, Error>) -> Void) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
    }

    private func setUpManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse || status == .authorizedAlways else {
            completionHandler?(.failure(LocationServiceError.authorityIsInsufficient))
            return
        }

        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completionHandler?(.failure(error))
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }

            if let error = error {
                self.completionHandler?(.failure(error))
                return
            }

            guard let placemark = placemarks?.first else {
                self.completionHandler?(.failure(LocationServiceError.placemarksIsEmpty))
                return
            }

            self.completionHandler?(.success(MKMapItem(placemark: .init(placemark: placemark))))
        }
    }
}
