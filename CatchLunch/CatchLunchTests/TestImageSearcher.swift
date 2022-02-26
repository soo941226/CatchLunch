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

    func test_요청을잘했는데_서버에서이상한응답을주면_응답이잘못되었다고_에러가뜬다() {
        //given
        imageSearcherUnderTeest.setUpRequest(request: .dataIsExist(
            flag: MockImageNetworkManager.stateOnWrongSearchResult
        ))
        let expectation = XCTestExpectation(description: "expect error")
        let targetDescription = ImageSearchError.searchResultIsWrong.errorDescription

        //when
        imageSearcherUnderTeest.fetch { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                //then
                XCTAssertEqual(targetDescription, error.errorDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_요청을잘했는데_이미지링크배열이들어있는아이템을안주면_안줬다고_에러가뜬다() {
        //given
        imageSearcherUnderTeest.setUpRequest(request: .dataIsExist(
            flag: MockImageNetworkManager.stateOnItemsIsNotExists
        ))
        let expectation = XCTestExpectation(description: "expect error")
        let targetDescription = ImageSearchError.itemsIsNotExists.errorDescription

        //when
        imageSearcherUnderTeest.fetch { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                //then
                XCTAssertEqual(targetDescription, error.errorDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_요청을잘했는데_서버에서준아이템에_링크가없으면_안줬다고_에러가뜬다() {
        //given
        imageSearcherUnderTeest.setUpRequest(request: .dataIsExist(
            flag: MockImageNetworkManager.stateOnLinkIsNotExists
        ))
        let expectation = XCTestExpectation(description: "expect error")
        let targetDescription = ImageSearchError.linkIsNotExists.errorDescription

        //when
        imageSearcherUnderTeest.fetch { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                //then
                XCTAssertEqual(targetDescription, error.errorDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_요청을잘했는데_서버에서준아이템의_URL이잘못되었으면_잘못되었다고_에러가뜬다() {
        //given
        imageSearcherUnderTeest.setUpRequest(request: .dataIsExist(
            flag: MockImageNetworkManager.stateOnWrongURL
        ))
        let expectation = XCTestExpectation(description: "expect error")
        let targetDescription = ImageSearchError.urlIsWrong.errorDescription

        //when
        imageSearcherUnderTeest.fetch { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                //then
                XCTAssertEqual(targetDescription, error.errorDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_요청을잘했는데_서버에서준URL로가져온_이미지가잘못되었으면_잘못되었다고_에러가뜬다() {
        //given
        imageSearcherUnderTeest.setUpRequest(request: .dataIsExist(
            flag: MockImageNetworkManager.stateOnWrongImageData
        ))
        let expectation = XCTestExpectation(description: "expect error")
        let targetDescription = ImageSearchError.imageDataIsWrong.errorDescription

        //when
        imageSearcherUnderTeest.fetch { result in
            switch result {
            case .success:
                XCTFail("error")
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                //then
                XCTAssertEqual(targetDescription, error.errorDescription)
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_요청을잘했는데_서버에서준URL로가져온_이미지가_괜찮으면_성공한다() {
        //given
        imageSearcherUnderTeest.setUpRequest(request: .dataIsExist(flag: "ok"))
        let expectation = XCTestExpectation(description: "expect error")

        //when
        imageSearcherUnderTeest.fetch { result in
            switch result {
            case .success(let image):
                //then
                XCTAssertGreaterThan(image.size.width, .zero)
                XCTAssertGreaterThan(image.size.height, .zero)
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
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



