//
//  MapRoutingViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/04/07.
//

import MapKit

final class MapRoutingViewController: UIViewController {
    private let viewModel: MapRouteViewModel
    private let mapView = MKMapView()
    private weak var coordiantor: Coordinatorable?

    init(viewModel: MapRouteViewModel, under coordiantor: Coordinatorable? = nil) {
        self.viewModel = viewModel
        self.coordiantor = coordiantor
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override func loadView() {
        view = mapView
        mapView.setCameraZoomRange(.init(maxCenterCoordinateDistance: 1000), animated: false)
    }
}
