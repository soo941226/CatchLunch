//
//  SearchViewModelable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/27.
//

import Foundation

protocol SearchViewModelable {
    associatedtype Service
    init(service: Service)
}

protocol JustSearchViewModelable: SearchViewModelable {
    associatedtype Item

    var searchBarPlaceHolder: String { get }
    var nextItems: [Item] { get }
    var nextIndexPaths: [IndexPath] { get }

    subscript(_ index: Int) -> RestaurantSummary? { get }

    func fetch(completionHandler: @escaping (Bool) -> Void)
}

protocol NameSearchViewModelable: SearchViewModelable {
    func fetch(about name: String, completionHandler: @escaping (Bool) -> Void)
}
