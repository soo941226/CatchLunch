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
        let jsonString = structUnderTest.jsonString
        let jsonData = jsonString.data(using: .utf8)

        do {
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }

            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

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
        structUnderTest.mainFoodNames = ""
        let jsonString = structUnderTest.jsonString
        let jsonData = jsonString.data(using: .utf8)

        do {
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }

            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            XCTAssertEqual(result.restaurantName, structUnderTest.restaurantName)
            XCTAssertEqual(result.mainFoodNames?.count, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_jsonString의_latitude가_이상하면_latitude는_nil이다() {
        structUnderTest.latitude = "치킨먹고싶다"
        let jsonString = structUnderTest.jsonString
        let jsonData = jsonString.data(using: .utf8)

        do {
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }

            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            XCTAssertNil(result.latitude)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_jsonString의_longitude가_이상하면_latitude는_nil이다() {
        structUnderTest.longitude = "치킨먹고싶다"
        let jsonString = structUnderTest.jsonString
        let jsonData = jsonString.data(using: .utf8)

        do {
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }

            let result = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            XCTAssertNil(result.longitude)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_jsonString에_타입이_이상하면_decode가_되지_않는다() {
        let jsonString = structUnderTest.wrongJSONString
        let jsonData = jsonString.data(using: .utf8)

        do {
            guard let jsonData = jsonData else {
                XCTFail("Something wrong")
                return
            }

            _ = try JSONDecoder().decode(RestaurantInformation.self, from: jsonData)

            XCTFail("잘되면 안됨")
        } catch {
            XCTAssertTrue(true, error.localizedDescription)
        }
    }

}
