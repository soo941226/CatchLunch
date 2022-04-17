//
//  CircleLabel.swift
//  CatchLunch
//
//  Created by kjs on 2022/04/18.
//

import UIKit

final class CircleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
    }

    required init(coder: NSCoder) {
        fatalError(.meesageAboutInterfaceBuilder)
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize

        if size.width.isLessThanOrEqualTo(size.height) {
            let basis = size.height * 1.2
            self.layer.cornerRadius = basis.half
            return .init(width: basis, height: basis)
        } else {
            let basis = size.width * 1.2
            self.layer.cornerRadius = basis.half
            return .init(width: basis, height: basis)
        }
    }
}
