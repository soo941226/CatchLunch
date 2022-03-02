//
//  SearchViewModelable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/27.
//

protocol SearchViewModelable {
    associatedtype Service: SearchService
    typealias Response = Service.Response

    init(service: Service)
    var service: Service { get }
    
    func fetch(completionHandler: @escaping (Bool) -> Void)
}
