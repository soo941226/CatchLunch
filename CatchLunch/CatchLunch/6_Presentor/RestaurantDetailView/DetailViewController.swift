//
//  DetailViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

final class DetailViewController<ViewModel: BookmarkViewModel>: UIViewController
where ViewModel.Element == RestaurantInformation {
    private let detailView = DetailInformationView()
    private let viewModel: ViewModel
    private var summary: RestaurantSummary?

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

    func configure(with summary: RestaurantSummary) {
        self.summary = summary

        viewModel.check(about: summary.information) { [weak self] isBookmarked in
            if isBookmarked != summary.information.isBookmarked {
                self?.summary?.information.toggledBookmark()
            }

            self?.toggleButton(on: isBookmarked)

            DispatchQueue.main.async {
                self?.navigationItem.title = summary.information.restaurantName
                self?.detailView.configure(with: summary)
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
        self.summary?.information.toggledBookmark()

        guard let summary = summary else { return }
        viewModel.toggle(about: summary.information)
        toggleButton(on: summary.information.isBookmarked)
    }
}
