//
//  RestaurantDetailViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import MapKit

final class RestaurantDetailViewController<ViewModel: BookmarkableViewModel>: UIViewController
where ViewModel.Element == RestaurantSummary {
    private let detailView = RestaurantDetailView()
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isRotateEnabled = false
        mapView.isPitchEnabled = false
        mapView.showsTraffic = false
        return mapView
    }()
    private let routingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("찾아가기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleEdgeInsets = .init(dx: .headInset, dy: .zero)
        button.layer.cornerRadius = .cornerRadius

        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()

    private let viewModel: ViewModel
    private weak var coordinator: Coordinatorable?

    init(with viewModel: ViewModel, coordinator: Coordinatorable? = nil) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        insertViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.check() { [weak self] in
            guard let self = self else { return }

            self.setUpNavigation()
            self.setUpContents()
            self.refreshBookmarkButton()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutSubviews()
    }

    private func setUpNavigation() {
        let summary = viewModel.element
        let bookmarkButton = UIBarButtonItem(
            image: nil, style: .plain,
            target: self, action: #selector(toggleBookmark)
        )
        navigationItem.title = summary.restaurantName
        navigationItem.setRightBarButton(bookmarkButton, animated: false)
    }

    private func setUpContents() {
        let summary = viewModel.element

        if let latitude = summary.latitude, let longitude = summary.longitude {
            focusMap(onY: latitude, andX: longitude)
        }

        detailView.configure(with: summary)
        routingButton.addTarget(self, action: #selector(routingStart), for: .touchUpInside)
    }

    @objc private func routingStart() {
        coordinator?.start()
    }

    @objc private func toggleBookmark() {
        viewModel.toggle { [weak self] in
            self?.refreshBookmarkButton()
        }
    }
}

// MARK: - Facade
extension RestaurantDetailViewController {
    func image(is image: UIImage?) {
        detailView.configure(image: image)
    }
}

// MARK: - set up views
private extension RestaurantDetailViewController {
    func insertViews() {
        detailView.insert(into: view)
        mapView.insert(into: view)
        routingButton.insert(into: view)
    }

    func layoutSubviews() {
        let safeArea = view.safeAreaLayoutGuide

        detailView.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        routingButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: detailView.bottomAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            routingButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: .headInset),
            routingButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: .tailInset)
        ])
    }

    func refreshBookmarkButton() {
        let buttonImage = viewModel.button
        navigationItem.rightBarButtonItem?.image = buttonImage
    }

    func focusMap(onY latitude: Double, andX longitude: Double) {
        let placeHolder = 2000.0
        mapView.isRotateEnabled = false
        mapView.isPitchEnabled = false
        mapView.setCameraZoomRange(.init(maxCenterCoordinateDistance: placeHolder), animated: false)
        mapView.setCenter(.init(latitude: latitude, longitude: longitude), animated: false)
        mapView.addAnnotation(MapMarker(latitdue: latitude, longitude: longitude))
    }
}
