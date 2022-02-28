//
//  SearchViewModelable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/27.
//

protocol SearchViewModelable {
    associatedtype Service: SearchService
    typealias Request = Service.Request
    typealias Response = Service.Response

    init(service: Service)
    var service: Service { get }
    var count: Int { get }
    func fetch(completionHandler: @escaping (Bool) -> Void)
}
