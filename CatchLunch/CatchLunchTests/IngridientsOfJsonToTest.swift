//
//  IngridientsOfJsonToTest.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/24.
//

struct IngridientsOfJsonToTest {
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

    var wrongJSONString: String {
        return """
{
    "SIGUN_NM": 1234,
    "RESTRT_NM": 1234,
    "TASTFDPLC_TELNO": 1234,
    "REPRSNT_FOOD_NM": 1234,
    "REFINE_ZIPNO": 1234,
    "REFINE_ROADNM_ADDR": 1234,
    "REFINE_LOTNO_ADDR": 1234,
    "REFINE_WGS84_LAT": 1234,
    "REFINE_WGS84_LOGT": 1234
}
"""
    }
}
