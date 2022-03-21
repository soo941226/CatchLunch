//
//  ViewModelable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/27.
//

import UIKit

protocol JustSearchViewModelable {
    associatedtype Item
    typealias ItemInformation = (summary: Item, image: UIImage)

    subscript(_ index: Int) -> ItemInformation? { get }

    var managingItems: [ItemInformation] { get }
    func fetch(completionHandler: @escaping (Bool) -> Void)
}

protocol NameSearchViewModelable {
    func fetch(about name: String, completionHandler: @escaping (Bool) -> Void)
}

protocol PagingSearchViewModelable: JustSearchViewModelable {
    var nextIndexPaths: [IndexPath] { get }
}
