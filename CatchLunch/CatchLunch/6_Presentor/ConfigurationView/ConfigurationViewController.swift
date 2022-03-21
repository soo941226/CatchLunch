//
//  ConfigurationViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/21.
//

import UIKit

final class ConfigurationViewController: UIViewController {
    private var coordinator: Coordiantorable?
    private let upperStackView = UIStackView()
    private let lowerStackView = UIStackView()
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
        setUpButtonStackView()
        setUpCommentStackView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let safeArea = view.safeAreaLayoutGuide
        upperStackView.translatesAutoresizingMaskIntoConstraints = false
        lowerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upperStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            upperStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            upperStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            lowerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            lowerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            lowerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }

    private func setUpCopyrightButton() {
        copyrightButton.insert(into: self.view)
        copyrightButton.setTitle("라이센스", for: .normal)
        copyrightButton.setImage(.init(systemName: "scroll.fill"), for: .normal)
        copyrightButton.addTarget(self, action: #selector(start), for: .touchUpInside)

        copyrightButton.setTitleColor(.label, for: .normal)
        copyrightButton.layer.borderWidth = 0.5
        copyrightButton.layer.borderColor = UIColor.lightGray.cgColor
        copyrightButton.layer.cornerRadius = 10.0
        copyrightButton.titleLabel?.numberOfLines = .zero
        copyrightButton.titleLabel?.font = .preferredFont(forTextStyle: .body)
    }

    private func setUpButtonStackView() {
        upperStackView.insert(into: self.view)
            .addArrangedSubviews(copyrightButton, UIView(), UIView())
            .configure(axis: .horizontal, distribution: .fillEqually, alignment: .fill)
    }

    private func setUpCommentStackView() {
        let versionLabel = UILabel()
        versionLabel.text = "v0.0.2"
        versionLabel.font = .preferredFont(forTextStyle: .caption2)
        versionLabel.textAlignment = .center
        versionLabel.textColor = .secondaryLabel

        lowerStackView.insert(into: self.view)
            .addArrangedSubviews(versionLabel)
            .configure(axis: .vertical, distribution: .fillEqually, alignment: .fill)
    }

    @objc private func start() {
        coordinator?.start()
    }
}
