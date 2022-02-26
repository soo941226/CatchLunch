//
//  TestImageSearcher.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/27.
//

import XCTest
@testable import CatchLunch

final class TestImageSearcher: XCTestCase {
    private var imageSearcherUnderTeest: ImageSearcher<MockImageNetworkManager>!

    override func setUp() {
        imageSearcherUnderTeest = ImageSearcher(manager: MockImageNetworkManager())
    }
    
    override func tearDown() {
        imageSearcherUnderTeest = nil
    }

    func test_request를_설정하지_않으면_설정하지_않았다고_에러가_발생한다() {
        //given
        let expectation = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.requestIsNotExist.errorDescription

        //when
        imageSearcherUnderTeest.fetch { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                //then
                let result = error.errorDescription
                XCTAssertEqual(result, targetDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_request를_설정했지만_응답데이터가비어있으면_에러가발생한다() {
        //given
        imageSearcherUnderTeest.setUpRequest(request: .dataIsNotExist)
        let expectation = XCTestExpectation(description: "expect error")
        let targetDescription = NetworkError.dataIsNotExist.errorDescription

        //when
        imageSearcherUnderTeest.fetch { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                //then
                let result = error.errorDescription
                XCTAssertEqual(result, targetDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_request를_설정했고_응답데이터가이미지면_UIImage를가져온다() {
        //given
        imageSearcherUnderTeest.setUpRequest(request: .dataIsExist)
        let expectation = XCTestExpectation(description: "expect error")
        let notWantedResult = CGSize.zero

        //when
        imageSearcherUnderTeest.fetch { result in
            switch result {
            case .success(let image):

                //then
                XCTAssertNotEqual(image.size, notWantedResult)
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                XCTFail(error.errorDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

