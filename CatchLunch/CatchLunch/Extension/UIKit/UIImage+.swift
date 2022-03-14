//
//  UIImage+.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/14.
//

import UIKit

extension UIImage {
    func filled(with color: UIColor) -> UIImage {
        return self.withTintColor(color, renderingMode: .alwaysOriginal)
    }
}
