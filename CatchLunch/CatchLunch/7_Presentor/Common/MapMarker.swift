//
//  MapMarker.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/11.
//

import MapKit

final class MapMarker: NSObject, MKAnnotation {
    private(set) var coordinate: CLLocationCoordinate2D

    init(latitdue: CGFloat, longitude: CGFloat) {
        self.coordinate = .init(latitude: latitdue, longitude: longitude)
    }
}
