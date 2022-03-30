//
//  RestaurantDetailViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

final class RestaurantDetailViewController<ViewModel: BookmarkViewModel>: UIViewController
where ViewModel.Element == RestaurantSummary {
    private let detailView = RestaurantDetailInformationView()
    private let viewModel: ViewModel
    private var information: RestaurantInformation?

    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override func loadView() {
        view = detailView
    }

    func configure(with information: RestaurantInformation) {
        self.information = information

        viewModel.check(about: information.summary) { [weak self] isBookmarked in
            if isBookmarked != information.summary.isBookmarked {
                self?.information?.summary.toggledBookmark()
            }

            self?.toggleButton(on: isBookmarked)

            DispatchQueue.main.async {
                self?.navigationItem.title = information.summary.restaurantName
                self?.detailView.configure(with: information)
            }
        }
    }

    private func toggleButton(on isBookmarked: Bool) {
        let image = isBookmarked ? viewModel.button.on : viewModel.button.off
        let bookmarkButton = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(toggleBookmark)
        )

        DispatchQueue.main.async { [weak self] in
            self?.navigationItem.setRightBarButton(bookmarkButton, animated: false)
        }
    }

    @objc private func toggleBookmark() {
        self.information?.summary.toggledBookmark()

        guard let information = information else { return }
        viewModel.toggle(about: information.summary)
        toggleButton(on: information.summary.isBookmarked)
    }
}
