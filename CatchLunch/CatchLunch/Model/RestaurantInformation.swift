//
//  RestaurantInformation.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/24.
//

import Foundation

struct RestaurantInformation: Restaurant, Coordinate, Bookmarkable, Decodable {
    private(set) var isBookmarked: Bool = false
    private(set) var cityName: String?
    private(set) var restaurantName: String?
    private(set) var phoneNumber: String?
    private(set) var refinedZipCode: String?
    private(set) var roadNameAddress: String?
    private(set) var locationNameAddress: String?
    private(set) var mainFoodNames: [String]?
    private(set) var latitude: Double?
    private(set) var longitude: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        setUpRestaurant(with: container)
        setUpPoint(with: container)
        setUpBookmarkable(with: container)
    }
    
    private mutating func setUpRestaurant(
        with container: KeyedDecodingContainer<CodingKeys>
    ) {
        let cityName = try? container.decode(String.self, forKey: .cityName)
        let restaurantName = try? container.decode(String.self, forKey: .restaurantName)
        let phoneNumber = try? container.decode(String.self, forKey: .phoneNumber)
        let refinedZipCode = try? container.decode(String.self, forKey: .refinedZipCode)
        let roadNameAddress = try? container.decode(String.self, forKey: .roadNameAddress)
        let locationNameAddress = try? container.decode(String.self, forKey: .locationNameAddress)
        
        self.cityName = cityName
        self.restaurantName = restaurantName
        self.phoneNumber = phoneNumber
        self.refinedZipCode = refinedZipCode
        self.roadNameAddress = roadNameAddress
        self.locationNameAddress = locationNameAddress
        
        let mainFoodNames = try? container
            .decode(String.self, forKey: .mainFoodNames)
            .split(separator: ",")
            .map({ $0.description.trimmingCharacters(in: .whitespaces) })
        
        self.mainFoodNames = mainFoodNames
    }
    
    private mutating func setUpBookmarkable(
        with container: KeyedDecodingContainer<CodingKeys>
    ) {
        let isBookmarked = try? container.decode(Bool.self, forKey: .isBookmarked)
        self.isBookmarked = isBookmarked == true ? true : false
    }
    
    private mutating func setUpPoint(
        with container: KeyedDecodingContainer<CodingKeys>
    ) {
        if let latitude = try? container.decode(String.self, forKey: .latitude) {
            self.latitude = Double(latitude)
        } else if let latitude = try? container.decode(Double.self, forKey: .latitude) {
            self.latitude = latitude
        }
        
        if let longitude = try? container.decode(String.self, forKey: .longitude) {
            self.longitude = Double(longitude)
        } else if let longitude = try? container.decode(Double.self, forKey: .longitude) {
            self.longitude = longitude
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case isBookmarked
        case cityName = "SIGUN_NM"
        case restaurantName = "RESTRT_NM"
        case phoneNumber = "TASTFDPLC_TELNO"
        case refinedZipCode = "REFINE_ZIPNO"
        case roadNameAddress = "REFINE_ROADNM_ADDR"
        case locationNameAddress = "REFINE_LOTNO_ADDR"
        case mainFoodNames = "REPRSNT_FOOD_NM"
        case latitude = "REFINE_WGS84_LAT"
        case longitude = "REFINE_WGS84_LOGT"
    }
}
