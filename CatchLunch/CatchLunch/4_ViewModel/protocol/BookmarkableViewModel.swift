//
//  BookmarkViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/13.
//

import UIKit

protocol BookmarkableViewModel {
    associatedtype Service
    associatedtype Element

    init(under: Service, with: Element)

    var element: Element { get }
    var error: Error? { get }
    var button: UIImage? { get }

    func check(then: @escaping () -> Void)
    func toggle(then: @escaping () -> Void)
}
