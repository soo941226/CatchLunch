//
//  ViewModelable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/27.
//

import UIKit

protocol JustSearchViewModelable: AnyObject {
    associatedtype Item
    typealias ItemInformation = (summary: Item, image: UIImage)

    var count: Int { get }
    subscript(_ index: Int) -> ItemInformation? { get }
    func fetch(completionHandler: @escaping (Bool) -> Void)
}

protocol NameSearchViewModelable: AnyObject {
    func fetch(about name: String, completionHandler: @escaping (Bool) -> Void)
}

protocol PagingSearchViewModelable: JustSearchViewModelable {
    var nextIndexPaths: [IndexPath] { get }
}
