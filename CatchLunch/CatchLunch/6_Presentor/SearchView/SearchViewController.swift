//
//  SearchViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/14.
//

import UIKit

final class SearchViewController: UITabBarController {
    private weak var coordinator: Coordiantorable?
    // TODO: private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.layer.borderWidth = 0.5

        navigationItem.rightBarButtonItem = .init(title: "Ⓒ", style: .plain, target: self, action: #selector(showModal))
    }

    override var selectedViewController: UIViewController? {
        didSet {
            selectedItemIndex = selectedIndex
        }
    }

    @objc dynamic var selectedItemIndex = Int.zero

    @objc func showModal() {
        let copyRightViewController = CopyRightViewController()
        copyRightViewController.view.backgroundColor = .lightGray
        copyRightViewController.view.layer.borderWidth = 0.5
        present(copyRightViewController, animated: true)
    }
}
