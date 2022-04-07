//
//  MapRouteViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/30.
//

import MapKit

final class MapRouteViewModel {
    private let service: MapRoutingService

    init(service: MapRoutingService = MapRoutingService()) {
        self.service = service
    }

    func route(
        to endPoint: CLLocationCoordinate2D,
        then completionHandler: @escaping (MKRoute) -> Void
    ) {
        service.requestRouting(toY: endPoint.latitude, andX: endPoint.longitude) { result in
            switch result {
            case .success(let routes):
                print(routes)
            case .failure(let error):
                print(error)
            }
        }
    }
}
