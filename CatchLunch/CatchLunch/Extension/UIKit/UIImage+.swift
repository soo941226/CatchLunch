//
//  UIImage+.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/14.
//

import UIKit

extension UIImage {
    static let forkKnifeCircle = UIImage(systemName: "fork.knife.circle")!
    static let starFill = UIImage(systemName: "star.fill")!
    static let star = UIImage(systemName: "star")!
    static let yum = UIImage(named: "yum")!
    static let cook = UIImage(named: "cook")!
    static let gearshapeFill = UIImage(systemName: "gearshape.fill")!

    func filled(with color: UIColor) -> UIImage {
        return self.withTintColor(color, renderingMode: .alwaysOriginal)
    }
}
