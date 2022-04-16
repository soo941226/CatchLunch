//
//  TestGyeonggiRestaurantsSearcher.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import XCTest
@testable import CatchLunch

final class TestGyeonggiRestaurantsSearcher: XCTestCase {
    private var restaurantSearcherUnderTest: GyeonggiRestaurantsSearcher!

    override func setUp() {
        restaurantSearcherUnderTest = GyeonggiRestaurantsSearcher(manager: MockRestaurantNetworkManager())
    }
    override func tearDown() {
        restaurantSearcherUnderTest = nil
    }
    
    func test_request를_잘못던지면_clientError를_던진다() {
        // given
        setUpHandler(data: Data(), code: 400)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = NetworkError.clientError(code: 400).errorDescription
        var resultToExpect = ""

        // when
        restaurantSearcherUnderTest.fetch(
            pageIndex: -1, requestItemAmount: 10
        ) { result in
            switch result {
            case .success(let result):
                XCTFail(result.description)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                resultToExpect = error.errorDescription
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertEqual(resultToExpect, expectation)
    }

    func test_pageIndex를0부터요청하면_데이터가없다는에러가뜬다() {
        // given
        setUpHandler(data: Data(), code: 200)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = NetworkError.dataIsNotExist.errorDescription
        var resultToExpect = ""

        // when
        restaurantSearcherUnderTest.fetch(
            pageIndex: 0, requestItemAmount: 10
        ) { result in
            switch result {
            case .success(let result):
                XCTFail(result.description)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                resultToExpect = error.errorDescription
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertEqual(resultToExpect, expectation)
    }

    func test_itemAmount를0이하로요청하면_데이터가_오지_않는다() {
        // given
        setUpHandler(data: StubGyeonggiAPIResult().emptyObject, code: 200)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = Int.zero
        var resultToExpect = Int.zero

        // when
        restaurantSearcherUnderTest.fetch(
            pageIndex: 1, requestItemAmount: 0
        ) { result in
            switch result {
            case .success(let result):
                resultToExpect = result.count
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }
                XCTFail(error.errorDescription)
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertEqual(resultToExpect, expectation)
    }

    func test_알수없는상황에_잘못된응답이와도_fatalError는_나지않는다() {
        // given
        setUpHandler(data: Data(), code: 1234, error: DummyError())
        let dispatch = XCTestExpectation(description: "expect error")

        // when
        restaurantSearcherUnderTest.fetch(
            pageIndex: .max, requestItemAmount: .max
        ) { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                XCTAssertTrue(true, error.localizedDescription)
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)
    }


    func test_서버에서_잘못된_데이터를_내려주면_디코딩에러가_난다() {
        // given
        setUpHandler(data: StubGyeonggiAPIResult().objectWithWrongFormmat, code: 200)
        let dispatch = XCTestExpectation(description: "expect error")
        var resultToExpeect: DecodingError?
        // when
        restaurantSearcherUnderTest.fetch(
            pageIndex: .max, requestItemAmount: .max
        ) { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                guard let error = error as? DecodingError else {
                    XCTFail(error.localizedDescription)
                    return
                }
                resultToExpeect = error
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        XCTAssertNotNil(resultToExpeect)
    }

    func test_상식적인pageIndex와amount를던지면_응답이잘온다() {
        // given
        setUpHandler(data: StubGyeonggiAPIResult().objectWithCount10, code: 200)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = 10
        var resultToExpect = Int.zero

        // when
        restaurantSearcherUnderTest.fetch(
            pageIndex: 1, requestItemAmount: 10
        ) { result in
            switch result {
            case .success(let result):
                resultToExpect = result.count
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }
                XCTFail(error.errorDescription)
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertEqual(resultToExpect, expectation)
    }
}
