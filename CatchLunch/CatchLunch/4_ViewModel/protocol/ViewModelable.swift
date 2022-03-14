//
//  ViewModelable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/27.
//

import UIKit

protocol ViewModelable {
    associatedtype Service
    init(service: Service)
}

protocol JustSearchViewModelable: ViewModelable {
    associatedtype Item
    typealias ItemSummary = (information: Item, image: UIImage)

    subscript(_ index: Int) -> ItemSummary? { get }
    var searchBarPlaceHolder: String { get }

    var managingItems: [ItemSummary] { get }
    func fetch(completionHandler: @escaping (Bool) -> Void)
}

protocol NameSearchViewModelable: ViewModelable {
    func fetch(about name: String, completionHandler: @escaping (Bool) -> Void)
}

protocol PagingSearchViewModelable: JustSearchViewModelable {
    var nextIndexPaths: [IndexPath] { get }
}
