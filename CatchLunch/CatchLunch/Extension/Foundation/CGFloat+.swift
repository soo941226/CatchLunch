//
//  CGFloat+.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/30.
//

import CoreGraphics

extension CGFloat {
    static let headInset: CGFloat = 10.0
    static let tailInset: CGFloat = -10.0
    static let cornerRadius: CGFloat = 8.0
    static let heightLimitOfImage: CGFloat = 200.0

    var half: Self {
        self * 0.5
    }
}
