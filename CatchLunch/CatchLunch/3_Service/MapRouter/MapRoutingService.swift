//
//  MapRoutingService.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/29.
//

import MapKit

final class MapRoutingService: NSObject {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    private var startPlace: MKMapItem?
    private var errorHandler: ((Error) -> Void)?

    override init() {
        super.init()
        setUpManager()
    }

    private func setUpManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - Facade
extension MapRoutingService {
    func setUp(errorHandler: @escaping (Error) -> Void) {
        self.errorHandler = errorHandler
    }

    func requestRouting(
        toY latitude: Double,
        andX longitude: Double,
        completionHandler: @escaping (Result<[MKRoute], Error>) -> Void
    ) {
        guard let startPlace = startPlace else {
            errorHandler?(MapRoutingError.locationsIsEmpty)
            return
        }

        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let endPlace = MKMapItem(placemark: .init(coordinate: coordinate))
        let request = MKDirections.Request()
        request.source = startPlace
        request.destination = endPlace

        let router = MKDirections(request: request)
        router.calculate { response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            } else if let response = response {
                completionHandler(.success(response.routes))
            } else {
                completionHandler(.failure(MapRoutingError.failedToRoute))
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension MapRoutingService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse || status == .authorizedAlways else {
            errorHandler?(MapRoutingError.authorityIsInsufficient)
            return
        }

        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorHandler?(error)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }

            if let error = error {
                self.errorHandler?(error)
                return
            }

            guard let placemark = placemarks?.first else {
                self.errorHandler?(MapRoutingError.placemarksIsEmpty)
                return
            }

            self.startPlace = MKMapItem(placemark: .init(placemark: placemark))
        }
    }
}