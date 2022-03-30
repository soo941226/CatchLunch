//
//  RestaurantDetailViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

final class RestaurantDetailViewController<ViewModel: BookmarkViewModel>: UIViewController
where ViewModel.Element == RestaurantInformation {
    private let detailView = RestaurantDetailView()
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
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.check() { [weak self] in
            guard let self = self else { return }
            self.refreshBookmarkButton()

            DispatchQueue.main.async {
                self.initView()
            }
        }
    }

    private func initView() {
        navigationItem.title = viewModel.information.summary.restaurantName
        detailView.configure(with: viewModel.information)
    }

    private func refreshBookmarkButton() {
        let buttonImage = viewModel.button
        let bookmarkButton = UIBarButtonItem(
            image: buttonImage,
            style: .plain,
            target: self,
            action: #selector(toggleBookmark)
        )

        DispatchQueue.main.async { [weak self] in
            self?.navigationItem.rightBarButtonItem = nil
            self?.navigationItem.setRightBarButton(bookmarkButton, animated: false)
        }
    }

    @objc private func toggleBookmark() {
        viewModel.toggle { [weak self] in
            self?.refreshBookmarkButton()
        }
    }
}
