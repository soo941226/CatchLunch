//
//  BookmarkdListViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/14.
//

import UIKit

final class BookmarkdListViewController<ViewModel: JustSearchViewModelable>: UIViewController
where ViewModel.Item == RestaurantSummary {
    private let viewModel: ViewModel
    private let tableView = UITableView()
    private let dataSource = RestaurantsViewDataSource<ViewModel>()
    private let delegate = RestaurantsViewDelegate()
    private weak var coordinator: Coordiantorable?

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    init(viewModel: ViewModel, under coordinator: Coordiantorable) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewConfiguration()
        setUpTableViewLayout()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetch { [weak self] isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension BookmarkdListViewController: RestaurantsViewModelContainer {
    var selectedModel: RestaurantInformation? {
        guard let selectedIndex = tableView.indexPathForSelectedRow?.row else {
            return nil
        }
        return viewModel[selectedIndex]
    }

    func select() {
        coordinator?.start()
    }

    func requestNextItems() { }
}
