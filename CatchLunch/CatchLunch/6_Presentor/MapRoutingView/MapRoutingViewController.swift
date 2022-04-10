//
//  MapRoutingViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/04/07.
//

import MapKit

final class MapRoutingViewController: UIViewController {
    private let viewModel: MapRouteViewModel
    private weak var coordiantor: Coordinatorable?

    private let tableView = UITableView()
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isRotateEnabled = false
        mapView.isPitchEnabled = false
        mapView.showsTraffic = false
        return mapView
    }()
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.backgroundColor = .systemBackground
        label.directionalLayoutMargins = .init(dx: .headInset, dy: .headInset)
        label.layer.cornerRadius = .cornerRadius
        return label
    }()

    private var guideDescriptions = [String]()

    init(viewModel: MapRouteViewModel, under coordiantor: Coordinatorable? = nil) {
        self.viewModel = viewModel
        self.coordiantor = coordiantor
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        configureTableView()
        configureLabel()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.route() { [weak self] routes in
            guard let self = self,
                  let route = routes?.first,
                  let startPlace = self.viewModel.startPlace else {
                return
            }

            self.mapView.setCenter(startPlace.placemark.coordinate, animated: false)
            self.mapView.setCameraZoomRange(.init(maxCenterCoordinateDistance: route.distance), animated: false)
            self.mapView.addOverlay(route.polyline)

            let distance = route.distance / 1000
            self.distanceLabel.text = distance.rounded().description + "km"

            let array: [String] = route.steps.compactMap { step in
                if step.instructions.isEmpty { return nil }

                let distanceDescription = step.distance.rounded().description
                return distanceDescription + "m, " + step.instructions
            }
            self.guideDescriptions = array
            self.tableView.reloadData()
        }
    }

    private func configureMapView() {
        mapView.insert(into: view)
        mapView.delegate = self
    }

    private func configureLabel() {
        distanceLabel.insert(into: view)
    }

    private func configureTableView() {
        tableView.insert(into: view)
        tableView.dataSource = self
        tableView.separatorColor = .label
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CELL")
    }

    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        mapView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.heightAnchor.constraint(equalTo: mapView.heightAnchor),
            distanceLabel.topAnchor.constraint(equalTo: mapView.topAnchor, constant: .headInset),
            distanceLabel.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: .tailInset)
        ])
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

extension MapRoutingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guideDescriptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.text = guideDescriptions[indexPath.row]
        cell.textLabel?.numberOfLines = .zero
        return cell
    }
}
