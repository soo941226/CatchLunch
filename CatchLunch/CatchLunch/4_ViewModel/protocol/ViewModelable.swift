//
//  ViewModelable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/27.
//

import Foundation

protocol JustSearchViewModelable: AnyObject {
    associatedtype Item

    var count: Int { get }
    subscript(_ index: Int) -> Item? { get }
    func search(completionHandler: @escaping (Bool) -> Void)
    func willDisappear()
}

protocol NameSearchViewModelable: AnyObject {
    func search(about name: String, completionHandler: @escaping (Bool) -> Void)
}

protocol PagingSearchViewModelable: JustSearchViewModelable {
    var nextIndexPaths: [IndexPath] { get }
}
