//
//  RestaurantsViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

import UIKit

protocol RestaurantsViewModelContainer: AnyObject {
    func requestNextItems()
}

final class RestaurantsViewController: UIViewController {
    private let viewModel = RestaurantsViewModel(service: GyeonggiRestaurantsSearcher())
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let dataSource = RestaurantsViewDataSource()
    private let delegate = RestaurantsViewDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        requestNextItems()

        searchBarConfiguraiton()
        setUpSearchBarLayout()

        tableViewConfiguration()
        setUpTableViewLayout()
    }

    private func searchBarConfiguraiton() {
        view.addSubview(searchBar)
        searchBar.barStyle = .black
        searchBar.placeholder = viewModel.searchBarPlaceHolder
    }

    private func setUpSearchBarLayout() {
        let safeArea = view.safeAreaLayoutGuide

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }

    private func tableViewConfiguration() {
        view.addSubview(tableView)
        tableView.dataSource = dataSource
        tableView.delegate = delegate

        delegate.setUpContainer(with: self)

        tableView.register(RestaurantsViewCell.self, forCellReuseIdentifier: RestaurantsViewCell.identifier)
    }

    private func setUpTableViewLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension RestaurantsViewController: RestaurantsViewModelContainer {
    func requestNextItems() {
        viewModel.fetch { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                let result = self.viewModel.nextItems
                let indexPathsToRefresh = self.viewModel.nextIndexPaths
                self.dataSource.append(result)
                self.tableView.insertRows(at: indexPathsToRefresh, with: .top)
            }
        }
    }
}
