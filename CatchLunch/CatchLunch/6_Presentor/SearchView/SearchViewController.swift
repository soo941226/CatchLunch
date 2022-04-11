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

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.layer.borderWidth = 0.5
    }

    override var selectedViewController: UIViewController? {
        didSet {
            selectedItemIndex = selectedIndex
        }
    }

    @objc dynamic var selectedItemIndex = Int.zero
}
