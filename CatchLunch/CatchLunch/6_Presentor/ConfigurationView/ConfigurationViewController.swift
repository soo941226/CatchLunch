//
//  ConfigurationViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/21.
//

import UIKit

final class ConfigurationViewController: UIViewController {
    private var coordinator: Coordiantorable?
    private let stackView = UIStackView()
    private let copyrightButton = GuideButton()

    init(under coordinator: Coordiantorable) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCopyrightButton()
        setUpStackView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let safeArea = view.safeAreaLayoutGuide
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }

    private func setUpCopyrightButton() {
        copyrightButton.insert(into: self.view)
        copyrightButton.setTitle("저작권", for: .normal)
        copyrightButton.setImage(.init(systemName: "scroll.fill"), for: .normal)
        copyrightButton.addTarget(self, action: #selector(start), for: .touchUpInside)

        copyrightButton.setTitleColor(.label, for: .normal)
        copyrightButton.layer.borderWidth = 0.5
        copyrightButton.layer.borderColor = UIColor.lightGray.cgColor
        copyrightButton.layer.cornerRadius = 10.0
        copyrightButton.titleLabel?.font = .preferredFont(forTextStyle: .body)
    }

    private func setUpStackView() {
        stackView.insert(into: self.view)
            .addArrangedSubviews(copyrightButton, UIView(), UIView())
            .configure(axis: .horizontal, distribution: .fillEqually, alignment: .fill)
    }

    @objc private func start() {
        coordinator?.start()
    }
}
