//
//  DetailViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/08.
//

import UIKit

final class DetailViewController: UIViewController {
    private let summary: RestaurantSummary
    private let detailView = DetailInformationView()

    init(with model: RestaurantSummary) {
        self.summary = model
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
        detailView.configure(with: summary)

        let bookmarkButton = UIBarButtonItem(
            image: .init(systemName: "star.fill"),
            style: .plain,
            target: nil,
            action: nil
        )

        navigationItem.title = summary.information.restaurantName
        navigationItem.setRightBarButton(bookmarkButton, animated: false)
    }
}
