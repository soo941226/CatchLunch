//
//  GyeonggiParagonRestaurantsAPIResult.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/21.
//

struct GyeonggiParagonRestaurantsAPIResult: Decodable {
    let place: [Place]?

    enum CodingKeys: String, CodingKey {
        case place = "ParagonRestaurant"
    }

    struct Place: Decodable {
        let row: [GyeonggiParagonRestaurant]?
    }
}

struct GyeonggiParagonRestaurant: Decodable {
    private(set) var cityName: String?
    private(set) var restaurantName: String?
    private(set) var phoneNumber: String?
    private(set) var refinedZipCode: String?
    private(set) var roadNameAddress: String?
    private(set) var locationNameAddress: String?
    private(set) var mainFoodNames: String?
    private(set) var latitude: String?
    private(set) var longitude: String?

    enum CodingKeys: String, CodingKey {
        case cityName = "SIGUN_NM"
        case restaurantName = "BIZESTBL_NM"
        case phoneNumber = "TELNO"
        case mainFoodNames = "MAIN_MENU_NM"
        case refinedZipCode = "REFINE_ZIP_CD"
        case roadNameAddress = "REFINE_ROADNM_ADDR"
        case locationNameAddress = "REFINE_LOTNO_ADDR"
        case latitude = "REFINE_WGS84_LAT"
        case longitude = "REFINE_WGS84_LOGT"
    }
}
