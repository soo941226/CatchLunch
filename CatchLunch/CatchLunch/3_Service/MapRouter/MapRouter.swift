//
//  MapRouter.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/29.
//

import MapKit

final class MapRouter {
    func requestRouting(
        from startPlace: MKMapItem,
        to endPlace: MKMapItem,
        completionHandler: @escaping (Result<[MKRoute], Error>) -> Void
    ) {
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
                completionHandler(.failure(MapRouterError.failedToRoute))
            }
        }
    }
}
