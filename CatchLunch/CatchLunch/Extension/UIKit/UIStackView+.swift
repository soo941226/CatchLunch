//
//  UIStackView+.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

extension UIStackView {
    @discardableResult
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

    @discardableResult
    func addArrangedSubviews(_ subviews: UIView...) -> Self {
        subviews.forEach { view in
            self.addArrangedSubview(view)
        }
        return self
    }
}
