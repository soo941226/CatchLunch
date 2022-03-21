//
//  GyeonggiAPIResult.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/03.
//

struct GyeonggiRestaurantsAPIResult: Decodable {
    let place: [Place]?

    enum CodingKeys: String, CodingKey {
        case place = "PlaceThatDoATasteyFoodSt"
    }

    struct Place: Decodable {
        let row: [RestaurantSummary]?
    }
}
