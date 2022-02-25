//
//  TestNetworkManager.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import XCTest
@testable import CatchLunch

final class TestNetworkManager: XCTestCase {
    private var networkManagerUnderTest: NetworkManager<MockSessionStatus, MockSession>!

    override func setUp() {
        networkManagerUnderTest = NetworkManager(session: MockSession())
    }

    override func tearDown() {
        networkManagerUnderTest = nil
    }

    func test_request를_설정하지않으면_설정하라는_에러가뜬다() {
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.requestIsNotExist.errorDescription

        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTFail(data.description)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                let result = error.errorDescription
                XCTAssertEqual(targetDescription, result)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request를잘설정했는데_응답데이터가없으면_데이터가없다는_에러가뜬다() {
        networkManagerUnderTest.setUpRequest(with: .dataIsNotExist)
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.dataIsNotExist.errorDescription

        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTFail(data.description)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                let result = error.errorDescription
                XCTAssertEqual(targetDescription, result)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request가_잘설정되어있어도_400번대응답이오면_클라이언트에러가_발생한다() {
        networkManagerUnderTest.setUpRequest(with: .clientError)
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.clientError(code: 400).errorDescription

        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTFail(data.description)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                let result = error.errorDescription
                XCTAssertEqual(targetDescription, result)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request가_잘설정되어있어도_500번대응답이오면_서버에러가_발생한다() {
        networkManagerUnderTest.setUpRequest(with: .serverError)
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.serverError(code: 500).errorDescription

        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTFail(data.description)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                let result = error.errorDescription
                XCTAssertEqual(targetDescription, result)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request가_잘설정되어있어도_예기치않은상황엔_에러가발생한다() {
        networkManagerUnderTest.setUpRequest(with: .criticalError)
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = DummyError.justError.localizedDescription

        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTFail(data.description)
            case .failure(let error):
                guard let error = error as? DummyError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                XCTAssertEqual(targetDescription, error.localizedDescription)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request가_잘설정되어있어도_서버가REST를_지키지_않았으면_data가없다는에러가뜬다() {
        networkManagerUnderTest.setUpRequest(with: .otherResponseError)
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.dataIsNotExist.errorDescription

        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTFail(data.description)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                let result = error.errorDescription
                XCTAssertEqual(targetDescription, result)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request가_잘설정되어있고_응답데이터도있으면_잘동작한다() {
        networkManagerUnderTest.setUpRequest(with: .dataIsExist)
        let expectaion = XCTestExpectation(description: "expect error")
        let dummyDataCount = Int.zero

        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.count, dummyDataCount)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                XCTFail(error.errorDescription)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }
}
