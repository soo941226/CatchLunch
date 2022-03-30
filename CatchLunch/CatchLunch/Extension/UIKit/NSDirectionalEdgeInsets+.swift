//
//  NSDirectionalEdgeInsets+.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/30.
//

import UIKit

extension NSDirectionalEdgeInsets {
    init(dx: CGFloat, dy: CGFloat) {
        self.init(top: dy, leading: dx, bottom: dy, trailing: dx)
    }
}
