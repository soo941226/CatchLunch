//
//  UIEdgeInsets+.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/14.
//

import UIKit

extension UIEdgeInsets {
    init(dx: CGFloat, dy: CGFloat) {
        self.init(top: dy, left: dx, bottom: dy, right: dx)
    }
}
