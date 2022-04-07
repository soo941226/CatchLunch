//
//  RestaurantDetailViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import MapKit

final class RestaurantDetailViewController<ViewModel: BookmarkableViewModel>: UIViewController
where ViewModel.Element == RestaurantInformation {
    private let detailView = RestaurantDetailView()
    private let mapView = MKMapView()
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
        insertViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.check() { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async { [weak self] in
                self?.setUpContents()
                self?.refreshBookmarkButton()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layoutSubviews()
    }

    private func setUpContents() {
        let summary = viewModel.information.summary
        let bookmarkButton = UIBarButtonItem(
            image: nil, style: .plain,
            target: self, action: #selector(toggleBookmark)
        )
        navigationItem.title = summary.restaurantName
        navigationItem.setRightBarButton(bookmarkButton, animated: false)

        detailView.configure(with: viewModel.information)
        routingButton.addTarget(self, action: #selector(routingStart), for: .touchUpInside)

        if let latitude = summary.latitude, let longitude = summary.longitude {
            focusMap(onY: latitude, andX: longitude)
        }
    }

    private func refreshBookmarkButton() {
        let buttonImage = viewModel.button
        DispatchQueue.main.async { [weak self] in
            self?.navigationItem.rightBarButtonItem?.image = buttonImage
        }
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

    private func focusMap(onY latitude: Double, andX longitude: Double) {
        let placeHolder = 2000.0
        mapView.isRotateEnabled = false
        mapView.isPitchEnabled = false
        mapView.setCameraZoomRange(.init(maxCenterCoordinateDistance: placeHolder), animated: false)
        mapView.setCenter(.init(latitude: latitude, longitude: longitude), animated: false)
        mapView.addAnnotation(MapMarker(latitdue: latitude, longitude: longitude))
    }
}
