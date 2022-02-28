//
//  SearchService.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

protocol SearchService {
    associatedtype NetworkManager: NetworkManagable
    associatedtype Response
    typealias Request = NetworkManager.Request

    var manager: NetworkManager { get }
    init(manager: NetworkManager )
    
    func setUpRequest(request: Request)
    func fetch(
        completionHandler: @escaping (Result<Response, Error>) -> Void
    )
}
