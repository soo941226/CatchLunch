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
        mapView.delegate = self
        mapView.setCameraZoomRange(.init(maxCenterCoordinateDistance: 10000), animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.route() { routes in
            guard let route = routes?.first,
                  let startPlace = self.viewModel.startPlace else {
                return
            }
            self.mapView.setCenter(startPlace.placemark.coordinate, animated: false)
            self.mapView.addOverlay(route.polyline)
            route.steps.forEach { eachResult in
                print(eachResult.instructions)
            }
        }
    }
}

extension MapRoutingViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let overlay = overlay as? MKPolyline else { return .init() }

        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 1.0
        renderer.strokeColor = .red
        return renderer
    }
}
