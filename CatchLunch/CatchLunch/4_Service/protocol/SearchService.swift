//
//  SearchService.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

import Foundation

protocol SearchService {
    associatedtype NetworkManager: NetworkManagable
    associatedtype Response

    var manager: NetworkManager { get }
    init(manager: NetworkManager )
    
    func setUpRequest(request: URLRequest)
    func fetch(
        completionHandler: @escaping (Result<Response, Error>) -> Void
    )
}
