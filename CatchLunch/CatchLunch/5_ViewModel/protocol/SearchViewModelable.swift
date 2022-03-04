//
//  SearchViewModelable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/27.
//

protocol SearchViewModelable {
    associatedtype Service
    init(service: Service)
}

protocol JustSearchViewModelable: SearchViewModelable {
    func fetch(completionHandler: @escaping (Bool) -> Void)
}

protocol NameSearchViewModelable: SearchViewModelable {
    func fetch(about name: String, completionHandler: @escaping (Bool) -> Void)
}
