//
//  SearchService.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

protocol SearchService {
    associatedtype Responseable
    associatedtype NetworkManager: NetworkManagable

    var manager: NetworkManager { get }
    init(manager: NetworkManager )
    
    func setUpRequest(request: NetworkManager.Requestable)
    func fetch(
        completionHandler: @escaping (Result<Responseable, Error>) -> Void
    )
}
