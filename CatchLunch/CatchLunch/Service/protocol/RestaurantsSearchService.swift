//
//  RestaurantsSearchService.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

protocol RestaurantsSearchService {
    associatedtype Requestable
    associatedtype Responseable: Restaurant

    var manager: NetworkManagable<Requestable> { get }
    init(manager: NetworkManagable<Requestable>)
    
    func setUpRequest(request: Requestable)
    func fetchRestaurant(
        pageIndex: Int,
        completionHandler: @escaping (Result<[Responseable], Error>) -> Void
    )
}
