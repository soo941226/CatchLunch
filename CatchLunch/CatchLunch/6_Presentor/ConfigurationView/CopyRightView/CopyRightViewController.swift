//
//  CopyRightViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/15.
//

import UIKit

final class CopyRightViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let button = UIButton()

    override func loadView() {
        view = scrollView
    }

    override func viewDidLoad() {
        scrollView.addSubview(button)
        button.setTitle("Logo: Meal Vectors by Vecteezy", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(go), for: .touchDown)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .systemBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20.0),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20.0)

        ])
    }

    @objc private func go() {
        UIApplication.shared.open(URL(string: "https://www.vecteezy.com/free-vector/meal")!, options: [:]) { bool in
            print(bool)
        }
    }
}
