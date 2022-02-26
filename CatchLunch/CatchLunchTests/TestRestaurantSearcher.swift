//
//  TestRestaurantSearcher.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import XCTest
@testable import CatchLunch

final class TestRestaurantSearcher: XCTestCase {
    private var restaurantSearcherUnderTest: RestaurantsSearcher<MockRestaurantNetworkManager>!

    override func setUp() {
        restaurantSearcherUnderTest = RestaurantsSearcher(manager: MockRestaurantNetworkManager())
    }
    override func tearDown() {
        restaurantSearcherUnderTest = nil
    }

    func test_setRequest를_하지_않으면_리퀘스트를설정하라는_에러가_발생한다() {
        //given
        let expectation = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.requestIsNotExist.localizedDescription

        //when
        restaurantSearcherUnderTest.fetch { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                //then
                let result = error.localizedDescription
                XCTAssertTrue(result == targetDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_setRequest가_잘못되면_데이터가없는_에러가_발생한다() {
        //given
        restaurantSearcherUnderTest.setUpRequest(request: .criticalError)
        let expectation = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.dataIsNotExist.localizedDescription

        //when
        restaurantSearcherUnderTest.fetch { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):

                //then
                let result = error.localizedDescription
                XCTAssertTrue(result == targetDescription)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_setRequest는_잘되었는데_response가_잘못되면_디코딩_에러가_발생한다() {
        //given
        restaurantSearcherUnderTest.setUpRequest(request: .dataIsNotExist)
        let expectation = XCTestExpectation(description: "expect error")

        //when
        restaurantSearcherUnderTest.fetch { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                //then
                if error is DecodingError {
                    XCTAssert(true, error.localizedDescription)
                } else {
                    XCTFail(error.localizedDescription)
                }
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_setRequest도_잘되고_response가_잘오면_성공한다() {
        //given
        restaurantSearcherUnderTest.setUpRequest(request: .dataIsExist(
            flag: MockRestaurantNetworkManager.just
        ))
        let expectation = XCTestExpectation(description: "expect error")

        //when
        restaurantSearcherUnderTest.fetch { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.count, 1)
                XCTAssertEqual(response[0].isBookmarked, false)
                XCTAssertEqual(response[0].cityName, "가평군")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
