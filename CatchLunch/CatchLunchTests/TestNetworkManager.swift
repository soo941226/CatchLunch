//
//  TestNetworkManager.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import XCTest
@testable import CatchLunch

final class TestNetworkManager: XCTestCase {
    private var networkManagerUnderTest: NetworkManager!

    override func setUp() {
        networkManagerUnderTest = NetworkManager(session: MockSessionAboutRestaurant())
    }

    override func tearDown() {
        networkManagerUnderTest = nil
    }

    func test_request를_설정하지않으면_설정하라는_에러가뜬다() {
        //given
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = NetworkError.requestIsNotExist.errorDescription
        var testResult = ""

        //when
        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTFail(data.description)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }


                testResult = error.errorDescription
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        //then
        XCTAssertEqual(expectation, testResult)
    }

    func test_request에_에러가있으면_에러가뜬다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .errorRequest)
        let dispatch = XCTestExpectation(description: "expect error")

        //when
        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTFail(data.description)
            case .failure(let error):
                //then
                XCTAssert(true, error.localizedDescription)
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)
    }

    func test_request를_잘설정했는데_응답데이터가없으면_데이터가없다는_에러가_뜬다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .dataIsNotExist)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = NetworkError.dataIsNotExist.errorDescription
        var testResult = ""

        //when
        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }
                testResult = error.errorDescription
            }
            dispatch.fulfill()
        }

        wait(for: [dispatch], timeout: 5.0)

        //then
        XCTAssertEqual(expectation, testResult)
    }

    func test_request가_잘설정되어있어도_400번대응답이오면_클라이언트에러가_발생한다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .clientError)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = NetworkError.clientError(code: 400).errorDescription
        var testResult = ""

        //when
        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTFail(data.description)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                testResult = error.errorDescription
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        //then
        XCTAssertEqual(expectation, testResult)
    }

    func test_request가_잘설정되어있어도_500번대응답이오면_서버에러가_발생한다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .serverError)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = NetworkError.serverError(code: 500).errorDescription
        var testResult = ""

        //when
        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTFail(data.description)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }
                testResult = error.errorDescription
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        //then
        XCTAssertEqual(expectation, testResult)
    }

    func test_request가_잘설정되어있어도_서버에문제가있을경우_data가없다고처리된다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .otherResponseError)
        let dispatch = XCTestExpectation(description: "expect error")
        let expection = NetworkError.uknownError(code: .zero).errorDescription
        var testResult = ""

        //when
        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                testResult = error.errorDescription
            }
            dispatch.fulfill()
        }

        wait(for: [dispatch], timeout: 5.0)
        XCTAssertEqual(testResult, expection)
    }

    func test_request가_잘설정되어있고_응답데이터도있으면_잘동작한다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .dummyRestaurantData)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = Int.zero
        var testResult = Int.min

        //when
        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                testResult = data.count
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


        //then
        XCTAssertGreaterThan(testResult, expectation)
    }
}

