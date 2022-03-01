//
//  TestNetworkManager.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import XCTest
@testable import CatchLunch

final class TestNetworkManager: XCTestCase {
    private var networkManagerUnderTest: NetworkManager<MockSession>!

    override func setUp() {
        networkManagerUnderTest = NetworkManager(session: MockSession())
    }

    override func tearDown() {
        networkManagerUnderTest = nil
    }

    func test_request를_설정하지않으면_설정하라는_에러가뜬다() {
        //given
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.requestIsNotExist.errorDescription

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

                //then
                let result = error.errorDescription
                XCTAssertEqual(targetDescription, result)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request를잘설정했는데_응답데이터가없으면_데이터가없다는_에러가뜬다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .dataIsNotExist)
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.dataIsNotExist.errorDescription

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

                //then
                let result = error.errorDescription
                XCTAssertEqual(targetDescription, result)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request가_잘설정되어있어도_400번대응답이오면_클라이언트에러가_발생한다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .clientError)
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.clientError(code: 400).errorDescription

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

                //then
                let result = error.errorDescription
                XCTAssertEqual(targetDescription, result)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request가_잘설정되어있어도_500번대응답이오면_서버에러가_발생한다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .serverError)
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.serverError(code: 500).errorDescription

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

                //then
                let result = error.errorDescription
                XCTAssertEqual(targetDescription, result)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request가_잘설정되어있어도_에러가넘어오면_에러를처리한다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .criticalError)
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = DummyError.justError.localizedDescription

        //when
        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):
                XCTFail(data.description)
            case .failure(let error):
                guard let error = error as? DummyError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                //then
                let result = error.localizedDescription
                XCTAssertEqual(targetDescription, result)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request가_잘설정되어있어도_서버가REST를_지키지_않았으면_data가없다는에러가뜬다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .otherResponseError)
        let expectaion = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.dataIsNotExist.errorDescription

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

                //then
                let result = error.errorDescription
                XCTAssertEqual(targetDescription, result)
            }
            expectaion.fulfill()
        }

        wait(for: [expectaion], timeout: 5.0)
    }

    func test_request가_잘설정되어있고_응답데이터도있으면_잘동작한다() {
        //given
        networkManagerUnderTest.setUpRequest(with: .dataIsExist(
            flag: MockSession.just
        ))
        let expectaion = XCTestExpectation(description: "expect error")
        let dummyDataCount = Int.zero


        //when
        networkManagerUnderTest.dataTask { result in
            switch result {
            case .success(let data):

                //then
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

    func test_basicNetworkManager에_url이_abcd인_reqeust를_setUp하면_얘의_request의url은_abcd다() {
        //given
        let basicNetworkManager = NetworkManagerFactory.basic()
        let urlString = "abcd"
        guard let url = URL(string: urlString) else {
            XCTFail("error")
            return
        }
        let urlRequest = URLRequest(url: url)

        //when
        basicNetworkManager.setUpRequest(with: urlRequest)


        //then
        XCTAssertEqual(basicNetworkManager.request?.url?.path, "abcd")
    }
}
