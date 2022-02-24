//
//  RestaurantInformation.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/24.
//

import Foundation

struct RestaurantInformation: Restaurant, Coordinate, Bookmarkable {
    private(set) var isBookmarked: Bool
    private(set) var cityName: String
    private(set) var restaurantName: String
    private(set) var contact: String?
    private(set) var refinedZipCode: String?
    private(set) var roadNameAddress: String?
    private(set) var locationNameAddress: String?
    private(set) var mainFoodNames: [String]?
    private(set) var latitude: Double
    private(set) var longitude: Double
}
