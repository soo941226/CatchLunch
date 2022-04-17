//
//  RestaurantsViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

import UIKit

final class RestaurantsViewController<ViewModel: PagingSearchViewModelable>: UIViewController
where ViewModel.Item == RestaurantSummary {
    private let viewModel: ViewModel
    private let tableView = UITableView()
    private let dataSource = RestaurantsViewDataSource<ViewModel>()
    private let delegate = RestaurantsViewDelegate()

    private weak var imageViewModel: ImageViewModel?
    private weak var coordinator: Coordinatorable?

    private var isLoad = true

    init(with viewModel: ViewModel, and imageViewModel: ImageViewModel, under coordinator: Coordinatorable) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.imageViewModel = imageViewModel
        delegate.configure(imageViewModel: imageViewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewConfiguration()
        setUpTableViewLayout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard isLoad else { return }
        requestNextItems()
        isLoad = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.willDisappear()
    }

    private func tableViewConfiguration() {
        dataSource.viewModel(is: viewModel)
        delegate.container(is: self)

        tableView.insert(into: view)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.register(RestaurantsViewCell.self, forCellReuseIdentifier: RestaurantsViewCell.identifier)
    }

    private func setUpTableViewLayout() {
        let safeArea = view.safeAreaLayoutGuide
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension RestaurantsViewController: RestaurantsViewModelAdopter {
    var selectedModel: RestaurantSummary? {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return nil
        }

        return viewModel[indexPath.row]
    }

    func retrieve(image completionHandler: @escaping (UIImage?) -> Void) {
        guard let mainFoodName = selectedModel?.mainFoodNames?.first else {
            completionHandler(nil)
            return
        }

        imageViewModel?.search(about: mainFoodName) { _ in
            completionHandler(self.imageViewModel?[mainFoodName])
        }
    }

    func select() {
        coordinator?.start()
    }

    func requestNextItems() {
        viewModel.search { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                let indexPathsToRefresh = self.viewModel.nextIndexPaths
                self.tableView.insertRows(at: indexPathsToRefresh, with: .bottom)
            }
        }
    }
}
