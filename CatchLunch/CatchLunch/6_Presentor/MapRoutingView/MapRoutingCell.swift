//
//  MapRoutingCell.swift
//  CatchLunch
//
//  Created by kjs on 2022/04/17.
//

import MapKit

final class MapRoutingCell: UITableViewCell {
    static let identifier = #fileID

    private let stackView = UIStackView()
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = .zero
        return label
    }()

    required init?(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
        setUpLayout()
    }
}

// MARK: - private methods of MapRoutingCell
private extension MapRoutingCell {
    func setUpSubviews() {
        stackView
            .addArrangedSubviews(distanceLabel, descriptionLabel)
            .configure(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: .pi)
            .insert(into: self)
    }

    func setUpLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            distanceLabel.widthAnchor.constraint(equalTo: descriptionLabel.widthAnchor, multiplier: 0.3),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - Facade
extension MapRoutingCell {
    func configure(with step: MKRoute.Step) {
        distanceLabel.text = step.distance.rounded().description + "m"
        descriptionLabel.text = step.instructions
    }
}
