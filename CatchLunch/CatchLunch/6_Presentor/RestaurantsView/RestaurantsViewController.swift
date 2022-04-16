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
    private weak var coordinator: Coordinatorable?

    init(with viewModel: ViewModel, under coordinator: Coordinatorable) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        requestNextItems()

        tableViewConfiguration()
        setUpTableViewLayout()
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

extension RestaurantsViewController: RestaurantsViewModelContainer {
    var selectedModel: RestaurantSummary? {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return nil
        }

        return viewModel[indexPath.row]
    }

    func select() {
        coordinator?.start()
    }

    func requestNextItems() {
        viewModel.fetch { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                let indexPathsToRefresh = self.viewModel.nextIndexPaths
                self.tableView.insertRows(at: indexPathsToRefresh, with: .bottom)
            }
        }
    }
}
