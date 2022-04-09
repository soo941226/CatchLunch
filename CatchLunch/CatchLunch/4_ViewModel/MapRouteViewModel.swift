//
//  MapRouteViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/30.
//

import MapKit

final class MapRouteViewModel {
    private let locationService = LocationService()
    private let mapRoutingService = MapRouter()
    private(set) var startPlace: MKMapItem?
    private(set) var endPlace: MKMapItem
    private(set) var error: Error?

    init(endPoint: CLLocationCoordinate2D) {
        endPlace = .init(placemark: .init(coordinate: endPoint))
    }

    func route(
        then completionHandler: @escaping ([MKRoute]?) -> Void
    ) {
        locationService.setUp { [weak self] resultOfLocation in
            guard let self = self else { return }
            switch resultOfLocation {
            case .success(let startPlace):
                self.startPlace = startPlace
                self.requestRoute(from: startPlace, to: self.endPlace, with: completionHandler)
            case .failure(let error):
                self.error = error
                completionHandler(nil)
            }
        }
    }

    private func requestRoute(
        from startPlace: MKMapItem,
        to endPlace: MKMapItem,
        with completionHandler: @escaping ([MKRoute]?) -> Void
    ) {
        mapRoutingService.requestRouting(
            from: startPlace,
            to: endPlace
        ) { resultOfMapRouting in
            switch resultOfMapRouting {
            case .success(let routes):
                completionHandler(routes)
            case .failure(let error):
                self.error = error
                completionHandler(nil)
            }
        }
    }
}
