//
//  RestaurantsSearchService.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

protocol RestaurantsSearchService {
    associatedtype Response = Restaurant

    func fetchRestaurant(
        where location: Coordinate,
        pageIndex: Int,
        then: @escaping (Result<[Response], Error>) -> Void
    )
}
