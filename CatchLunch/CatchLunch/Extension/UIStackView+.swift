//
//  UIStackView+.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

extension UIStackView {
    func configure(
        axis: NSLayoutConstraint.Axis,
        distribution: Distribution,
        alignment: Alignment,
        spacing: CGFloat = .zero
    ) -> Self {
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        return self
    }

    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { view in
            self.addArrangedSubview(view)
        }
    }

    func addBorder(color: UIColor) {
        self.subviews.forEach { view in
            view.backgroundColor = .systemBackground
        }

        self.backgroundColor = color
    }
}
