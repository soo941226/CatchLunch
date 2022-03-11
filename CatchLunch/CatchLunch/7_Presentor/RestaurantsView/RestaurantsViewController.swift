//
//  RestaurantsViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

import UIKit

final class RestaurantsViewController<
    ViewModel: JustSearchViewModelable
>: UIViewController where ViewModel.Item == RestaurantSummary {

    private let viewModel: ViewModel
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let dataSource = RestaurantsViewDataSource()
    private let delegate = RestaurantsViewDelegate()
    private let coordinator: Coordiantorable

    init(with viewModel: ViewModel, under coordinator: Coordiantorable) {
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

        searchBarConfiguraiton()

        tableViewConfiguration()
        setUpTableViewLayout()
    }

    private func searchBarConfiguraiton() {
        navigationItem.titleView = searchBar
        searchBar.barStyle = .default
        searchBar.placeholder = viewModel.searchBarPlaceHolder
    }

    private func tableViewConfiguration() {
        tableView.insert(into: view)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        delegate.container(is: self)

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
        coordinator.next()
    }

    func requestNextItems() {
        viewModel.fetch { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                let result = self.viewModel.nextItems
                let indexPathsToRefresh = self.viewModel.nextIndexPaths
                self.dataSource.append(result)
                self.tableView.insertRows(at: indexPathsToRefresh, with: .bottom)
            }
        }
    }
}
