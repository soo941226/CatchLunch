//
//  UIView+.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/10.
//

import UIKit

extension UIView {
    @discardableResult
    func insert(into target: UIView?) -> Self {
        target?.addSubview(self)
        return self
    }
}
