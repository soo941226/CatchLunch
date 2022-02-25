//
//  RestaurantsSearchService.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

protocol RestaurantsSearchService {
    associatedtype Responseable: Restaurant
    associatedtype NetworkManager: NetworkManagable

    var manager: NetworkManager { get }
    init(manager: NetworkManager )
    
    func setUpRequest(request: NetworkManager.Session.Requestable)
    func fetchRestaurant(
        pageIndex: Int,
        completionHandler: @escaping (Result<[Responseable], Error>) -> Void
    )
}
