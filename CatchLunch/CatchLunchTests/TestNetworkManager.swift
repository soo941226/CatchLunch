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
        networkManagerUnderTest = NetworkManager(session: MockSession())
    }

    override func tearDown() {
        networkManagerUnderTest = nil
    }

    func test_request를_설정하지않으면_설정하라는_에러가뜬다() {
        // given
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = NetworkError.requestIsNotExist.errorDescription
        var testResult = ""

        // when
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

        // then
        XCTAssertEqual(expectation, testResult)
    }

    func test_200번대로_응답데이터가비어있으면_데이터가없다는_에러가_뜬다() {
        // given
        setUpHandler(data: Data(), code: 200)
        networkManagerUnderTest.setUpRequest(with: dummyURLRequest)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = NetworkError.dataIsNotExist.errorDescription
        var testResult = ""

        // when
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

        // then
        XCTAssertEqual(expectation, testResult)
    }

    func test_400번대응답이오면_클라이언트에러가_발생한다() {
        // given
        setUpHandler(data: Data(), code: 400)
        networkManagerUnderTest.setUpRequest(with: dummyURLRequest)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = NetworkError.clientError(code: 400).errorDescription
        var testResult = ""

        // when
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

        // then
        XCTAssertEqual(expectation, testResult)
    }

    func test_500번대응답이오면_서버에러가_발생한다() {
        // given
        setUpHandler(data: Data(), code: 500)
        networkManagerUnderTest.setUpRequest(with: dummyURLRequest)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = NetworkError.serverError(code: 500).errorDescription
        var testResult = ""

        // when
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

        // then
        XCTAssertEqual(expectation, testResult)
    }

    func test_알수없는응답이오면_알수없는에러로_처리가된다() {
        // given
        let randomNumber = Int.random(in: 000...100)
        setUpHandler(data: Data(), code: randomNumber)
        networkManagerUnderTest.setUpRequest(with: dummyURLRequest)
        let dispatch = XCTestExpectation(description: "expect error")
        let expection = NetworkError.uknownError(code: randomNumber).errorDescription
        var testResult = ""

        // when
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

    func test_서버로부터_에러가_오면_에러처리를_한다() {
        setUpHandler(data: Data(), code: 200, error: DummyError())
        networkManagerUnderTest.setUpRequest(with: dummyURLRequest)
        let dispatch = XCTestExpectation(description: "expect error")
        var resultToExpect: Error?

        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                resultToExpect = error
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertNotNil(resultToExpect)
    }

    func test_request가_잘설정되어있고_응답데이터도있으면_잘동작한다() {
        // given
        setUpHandler(data: StubGyeonggiAPIResult().objectWithCount10, code: 200)
        networkManagerUnderTest.setUpRequest(with: dummyURLRequest)
        let dispatch = XCTestExpectation(description: "expect error")
        let expectation = Int.zero
        var testResult = Int.min

        // when
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

        // then
        XCTAssertGreaterThan(testResult, expectation)
    }
}
