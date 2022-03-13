//
//  BookmarkViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/13.
//

import UIKit

protocol BookmarkViewModel {
    associatedtype Service
    associatedtype Element

    init(under: Service)

    var error: Error? { get }
    var button: (on: UIImage?, off: UIImage?) { get }

    func check(about: Element, then: @escaping (_ isBookmarked: Bool) -> Void)
    func toggle(about: Element)
}
