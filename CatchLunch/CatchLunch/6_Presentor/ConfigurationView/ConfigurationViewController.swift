//
//  ConfigurationViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/21.
//

import UIKit

final class ConfigurationViewController: UIViewController {
    private weak var coordinator: Coordiantorable?
    private let upperStackView = UIStackView()
    private let lowerStackView = UIStackView()
    private let copyrightButton = GuideButton()
    private let cautionButton = GuideButton()

    private(set) var selected = Selected.copyright

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
        setUpCautionButton()
        setUpButtonStackView()
        setUpCommentStackView()
        setUpStyle(ofButtons: copyrightButton, cautionButton)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let safeArea = view.safeAreaLayoutGuide
        upperStackView.translatesAutoresizingMaskIntoConstraints = false
        lowerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upperStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            upperStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: .pi),
            upperStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: .pi),
            lowerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            lowerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: .pi),
            lowerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: .pi)
        ])
    }

    private func setUpStyle(ofButtons buttons: UIButton...) {
        buttons.forEach { button in
            button.setTitleColor(.label, for: .normal)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.systemBlue.cgColor
            button.layer.cornerRadius = 10.0
            button.titleLabel?.numberOfLines = .zero
            button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        }
    }

    private func setUpCautionButton() {
        cautionButton.insert(into: self.view)
        cautionButton.setTitle("유의사항", for: .normal)
        cautionButton.setImage(.init(systemName: "exclamationmark.circle.fill"), for: .normal)
        cautionButton.addTarget(self, action: #selector(onClickCatuionButton), for: .touchUpInside)
    }

    private func setUpCopyrightButton() {
        copyrightButton.insert(into: self.view)
        copyrightButton.setTitle("라이센스", for: .normal)
        copyrightButton.setImage(.init(systemName: "scroll.fill"), for: .normal)
        copyrightButton.addTarget(self, action: #selector(onClickCopyrightButton), for: .touchUpInside)
    }

    private func setUpButtonStackView() {
        upperStackView.insert(into: self.view)
            .addArrangedSubviews(copyrightButton, cautionButton, UIView())
            .configure(axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: .pi)
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

    @objc private func onClickCatuionButton() {
        selected = .caution
        coordinator?.start()
    }

    @objc private func onClickCopyrightButton() {
        selected = .copyright
        coordinator?.start()
    }

    enum Selected {
        case copyright
        case caution
    }
}
