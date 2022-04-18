//
//  SearchViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/14.
//

import UIKit

final class SearchViewController: UITabBarController {
    private weak var coordinator: Coordinatorable?
    let imageViewModel: ImageViewModel
    // TODO: private let searchBar = UISearchBar()

    init(imageViewModel: ImageViewModel) {
        self.imageViewModel = imageViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpTabBarBorder()
    }

    override var selectedViewController: UIViewController? {
        didSet {
            selectedItemIndex = selectedIndex
        }
    }

    @objc dynamic var selectedItemIndex = Int.zero

    private func setUpTabBarBorder() {
        let layer = tabBar.layer
        let basis: CGFloat = 0.5
        let edgeInset = UIEdgeInsets(top: basis, left: -basis, bottom: -basis, right: -basis)

        layer.frame = layer.frame.inset(by: edgeInset)
        layer.borderColor = UIColor.secondarySystemFill.cgColor
        layer.borderWidth = basis
    }
}
