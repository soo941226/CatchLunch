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
    func fetch(completionHandler: @escaping (Bool) -> Void)
}

protocol NameSearchViewModelable: ViewModelable {
    func fetch(about name: String, completionHandler: @escaping (Bool) -> Void)
}

protocol PagingSearchViewModelable: JustSearchViewModelable {
    associatedtype Item

    var searchBarPlaceHolder: String { get }
    var nextItems: [(information: Item, image: UIImage)] { get }
    var nextIndexPaths: [IndexPath] { get }

    subscript(_ index: Int) -> (information: Item, image: UIImage)? { get }
}
