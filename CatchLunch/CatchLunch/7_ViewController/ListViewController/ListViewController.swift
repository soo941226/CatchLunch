//
//  ListViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

import UIKit

final class ListViewController: UIViewController {
    private let viewModel = RestaurantsViewModel(service: GyeonggiRestaurantsSearcher())
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let tableViewDataSource = RestaurantDataSource()

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
        searchBar.placeholder = "식당이름, 도시이름, 음식이름"
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

    private func requestNextItems() {
        viewModel.fetch { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                let result = self.viewModel.nextItems
                self.tableViewDataSource.append(result)
                self.tableView.reloadData()
            }
        }
    }

    private func tableViewConfiguration() {
        view.addSubview(tableView)
        tableView.dataSource = tableViewDataSource
        tableView.register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.identifier)
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
