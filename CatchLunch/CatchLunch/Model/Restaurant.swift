//
//  Restaurant.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

protocol Restaurant {
    var isBookmarked: Bool { get }
    var cityName: String { get }
    var restaurantName: String { get }
    var contact: String? { get }
    var refinedZipCode: String? { get }
    var roadNameAddress: String? { get }
    var locationNameAddress: String? { get }
    var mainFoodNames: [String]? { get }
}
