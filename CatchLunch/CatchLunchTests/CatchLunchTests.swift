//
//  CatchLunchTests.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/23.
//

import XCTest
@testable import CatchLunch

final class CatchLunchTests: XCTestCase {
    private var structUnderTest: IngridientsOfJsonToTest!

    override func setUp() {
        structUnderTest = IngridientsOfJsonToTest(
            cityName: "가평군",
            restaurantName: "가평축협 한우명가",
            phoneNumber: "031-581-1592",
            mainFoodNames: "푸른연잎한우명품꽃등심",
            refinedZipCode: "12422",
            roadNameAddress: "경기도 가평군 가평읍 달전로 19",
            locationNameAddress: "경기도 가평군 가평읍 달전리 382-1번지",
            latitude: "37.8158443",
            longitude: "127.5161283"
        )
    }

    override func tearDown() {
        structUnderTest = nil
    }

    func test_jsonString은_restaurant로_잘_디코딩이_된다() {
        //given
        let jsonString = structUnderTest.jsonString
        let jsonData = jsonString.data(using: .utf8)

        do {
            //when
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }
            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            //then
            XCTAssertEqual(result.isBookmarked, false)
            XCTAssertEqual(result.cityName, structUnderTest.cityName)
            XCTAssertEqual(result.restaurantName, structUnderTest.restaurantName)
            XCTAssertEqual(result.roadNameAddress, structUnderTest.roadNameAddress)
            XCTAssertEqual(result.refinedZipCode, structUnderTest.refinedZipCode)
            XCTAssertEqual(result.phoneNumber, structUnderTest.phoneNumber)
            XCTAssertEqual(result.longitude?.description, structUnderTest.longitude)
            XCTAssertEqual(result.latitude?.description, structUnderTest.latitude)
            XCTAssertEqual(result.mainFoodNames?.count, 1)
            XCTAssertEqual(result.mainFoodNames?[0], "푸른연잎한우명품꽃등심")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_jsonString의_메인음식이름들이없어도_잘_디코딩이_된다() {
        //given
        structUnderTest.mainFoodNames = ""
        let jsonString = structUnderTest.jsonString
        let jsonData = jsonString.data(using: .utf8)

        do {
            //when
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }
            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            //then
            XCTAssertEqual(result.restaurantName, structUnderTest.restaurantName)
            XCTAssertEqual(result.mainFoodNames?.count, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_jsonString의_latitude가_이상하면_latitude는_nil이다() {
        //given
        structUnderTest.latitude = "치킨먹고싶다"
        let jsonString = structUnderTest.jsonString
        let jsonData = jsonString.data(using: .utf8)

        do {
            //when
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }
            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            //then
            XCTAssertNil(result.latitude)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_jsonString의_longitude가_이상하면_latitude는_nil이다() {
        //given
        structUnderTest.longitude = "치킨먹고싶다"
        let jsonString = structUnderTest.jsonString
        let jsonData = jsonString.data(using: .utf8)

        do {
            //when
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }
            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            //then
            XCTAssertNil(result.longitude)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_jsonString에_Restaurant타입의_프로퍼티가_누락되도_decode은_된다() {
        //given
        let jsonStringWithoutCityName = """
{
    "RESTRT_NM": "\(structUnderTest.restaurantName)",
    "TASTFDPLC_TELNO": "\(structUnderTest.phoneNumber)",
    "REPRSNT_FOOD_NM": "\(structUnderTest.mainFoodNames)",
    "REFINE_ZIPNO": "\(structUnderTest.refinedZipCode)",
    "REFINE_ROADNM_ADDR": "\(structUnderTest.roadNameAddress)",
    "REFINE_LOTNO_ADDR": "\(structUnderTest.locationNameAddress)",
    "REFINE_WGS84_LAT": "\(structUnderTest.latitude)",
    "REFINE_WGS84_LOGT": "\(structUnderTest.longitude)"
}
"""
        let jsonData = jsonStringWithoutCityName.data(using: .utf8)

        do {
            //when
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }
            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            //then
            XCTAssertNil(result.cityName)
            XCTAssertEqual(result.restaurantName, structUnderTest.restaurantName)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_jsonString에_Restaurant타입의_프로퍼티가_타입이달라도_디코딩은_된다() {
        //given
        let jsonStringWithWrongCityName = """
{
    "SIGUN_NM": 1234,
    "RESTRT_NM": "\(structUnderTest.restaurantName)",
    "TASTFDPLC_TELNO": "\(structUnderTest.phoneNumber)",
    "REPRSNT_FOOD_NM": "\(structUnderTest.mainFoodNames)",
    "REFINE_ZIPNO": "\(structUnderTest.refinedZipCode)",
    "REFINE_ROADNM_ADDR": "\(structUnderTest.roadNameAddress)",
    "REFINE_LOTNO_ADDR": "\(structUnderTest.locationNameAddress)",
    "REFINE_WGS84_LAT": "\(structUnderTest.latitude)",
    "REFINE_WGS84_LOGT": "\(structUnderTest.longitude)"
}
"""
        let jsonData = jsonStringWithWrongCityName.data(using: .utf8)

        do {
            //when
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }
            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            //then
            XCTAssertNil(result.cityName)
            XCTAssertEqual(result.restaurantName, structUnderTest.restaurantName)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_jsonString에_Coordinate타입의_longitude가_타입이달라도_디코딩이_된다() {
        //given
        let jsonStringWithWrongLongitude = """
{
    "SIGUN_NM": "\(structUnderTest.cityName)",
    "RESTRT_NM": "\(structUnderTest.restaurantName)",
    "TASTFDPLC_TELNO": "\(structUnderTest.phoneNumber)",
    "REPRSNT_FOOD_NM": "\(structUnderTest.mainFoodNames)",
    "REFINE_ZIPNO": "\(structUnderTest.refinedZipCode)",
    "REFINE_ROADNM_ADDR": "\(structUnderTest.roadNameAddress)",
    "REFINE_LOTNO_ADDR": "\(structUnderTest.locationNameAddress)",
    "REFINE_WGS84_LAT": "\(structUnderTest.latitude)",
    "REFINE_WGS84_LOGT": \(structUnderTest.longitude)
}
"""
        let jsonData = jsonStringWithWrongLongitude.data(using: .utf8)

        do {
            //when
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }
            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            //then
            XCTAssertEqual(result.cityName, structUnderTest.cityName)
            XCTAssertEqual(result.longitude?.description, structUnderTest.longitude)
            XCTAssertEqual(result.latitude?.description, structUnderTest.latitude)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_jsonString에_Coordinate타입의_latitude가_타입이달라도_디코딩이_된다() {
        //given
        let jsonStringWithWrongLatitude = """
{
    "SIGUN_NM": "\(structUnderTest.cityName)",
    "RESTRT_NM": "\(structUnderTest.restaurantName)",
    "TASTFDPLC_TELNO": "\(structUnderTest.phoneNumber)",
    "REPRSNT_FOOD_NM": "\(structUnderTest.mainFoodNames)",
    "REFINE_ZIPNO": "\(structUnderTest.refinedZipCode)",
    "REFINE_ROADNM_ADDR": "\(structUnderTest.roadNameAddress)",
    "REFINE_LOTNO_ADDR": "\(structUnderTest.locationNameAddress)",
    "REFINE_WGS84_LAT": \(structUnderTest.latitude),
    "REFINE_WGS84_LOGT": "\(structUnderTest.longitude)"
}
"""
        let jsonData = jsonStringWithWrongLatitude.data(using: .utf8)

        do {
            //when
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }
            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            //then
            XCTAssertEqual(result.cityName, structUnderTest.cityName)
            XCTAssertEqual(result.longitude?.description, structUnderTest.longitude)
            XCTAssertEqual(result.latitude?.description, structUnderTest.latitude)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}
