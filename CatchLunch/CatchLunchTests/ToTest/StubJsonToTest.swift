//
//  StubJsonToTest.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/24.
//

struct StubJsonToTest {
    var cityName: String
    var restaurantName: String
    var phoneNumber: String
    var mainFoodNames: String
    var refinedZipCode: String
    var roadNameAddress: String
    var locationNameAddress: String
    var latitude: String
    var longitude: String

    var jsonString: String {
        return """
{
    "SIGUN_NM": "\(cityName)",
    "RESTRT_NM": "\(restaurantName)",
    "TASTFDPLC_TELNO": "\(phoneNumber)",
    "REPRSNT_FOOD_NM": "\(mainFoodNames)",
    "REFINE_ZIPNO": "\(refinedZipCode)",
    "REFINE_ROADNM_ADDR": "\(roadNameAddress)",
    "REFINE_LOTNO_ADDR": "\(locationNameAddress)",
    "REFINE_WGS84_LAT": "\(latitude)",
    "REFINE_WGS84_LOGT": "\(longitude)"
}
"""
    }
}
