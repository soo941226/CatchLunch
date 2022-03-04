//
//  TestImageSearcher.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/27.
//

import XCTest
@testable import CatchLunch

final class TestImageSearcher: XCTestCase {
    private var imageSearcherUnderTeest: NaverImageSearcher!

    // MARK: - test를 위해 fetch시 넘겨주는 이미지명을 통해서 응답이 바뀌도록 분기처리를 해놓았음
    override func setUp() {
        imageSearcherUnderTeest = NaverImageSearcher(manager: MockImageNetworkManager())
    }

    override func tearDown() {
        imageSearcherUnderTeest = nil
    }

    func test_요청에대한응답이_이미지가아니면_이미지가아니라고_에러가_뜬다() {
        // given
        let dispatch = XCTestExpectation()
        let expectation = ImageSearchError.imageDataIsWrong.errorDescription
        var resultToExpect = ""

        // when
        imageSearcherUnderTeest.fetch(about: "notAnImage") { result in
            switch result {
            case .success(let image):
                XCTFail(image.description)
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                resultToExpect = error.errorDescription
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertEqual(expectation, resultToExpect)
    }

    func test_요청에대한응답이_잘못되었으면_응답이_잘못되었다고_에러가_든다() {
        // given
        let dispatch = XCTestExpectation()
        let expectation = ImageSearchError.searchResultIsWrong.errorDescription
        var resultToExpect = ""

        // when
        imageSearcherUnderTeest.fetch(about: "failToParse") { result in
            switch result {
            case .success(let image):
                XCTFail(image.description)
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                resultToExpect = error.errorDescription
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertEqual(expectation, resultToExpect)
    }

    func test_요청에대한응답에서_items가_비어있으면_비어있다고_에러가_뜬다() {
        // given
        let dispatch = XCTestExpectation()
        let expectation = ImageSearchError.itemsIsNotExists.errorDescription
        var resultToExpect = ""

        // when
        imageSearcherUnderTeest.fetch(about: "emptyResponse") { result in
            switch result {
            case .success(let image):
                XCTFail(image.description)
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                resultToExpect = error.errorDescription
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertEqual(expectation, resultToExpect)
    }

    func test_요청에대한응답에서_thumbnail이_비어있으면_비어있다고_에러가_뜬다() {
        // given
        let dispatch = XCTestExpectation()
        let expectation = ImageSearchError.linkIsNotExists.errorDescription
        var resultToExpect = ""

        // when
        imageSearcherUnderTeest.fetch(about: "emptyLink") { result in
            switch result {
            case .success(let image):
                XCTFail(image.description)
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                resultToExpect = error.errorDescription
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertEqual(expectation, resultToExpect)
    }

    func test_요청에대한응답에서_thumbnail의_link가_잘못되었으면_잘못되었다고_에러가_뜬다() {
        // given
        let dispatch = XCTestExpectation()
        let expectation = ImageSearchError.urlIsWrong.errorDescription
        var resultToExpect = ""

        // when
        imageSearcherUnderTeest.fetch(about: "invalidLink") { result in
            switch result {
            case .success(let image):
                XCTFail(image.description)
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                resultToExpect = error.errorDescription
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertEqual(expectation, resultToExpect)
    }

    func test_요청에대한응답에서_thumbnail의_데이터가_잘못되어서_비어있으면_비어있다고_에러가_뜬다() {
        // given
        let dispatch = XCTestExpectation()
        let expectation = NetworkError.dataIsNotExist.errorDescription
        var resultToExpect = ""

        // when
        imageSearcherUnderTeest.fetch(about: "invaildData") { result in
            switch result {
            case .success(let image):
                XCTFail(image.description)
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
        XCTAssertEqual(expectation, resultToExpect)
    }

    func test_요청에대한응답에서_thumbnail의_데이터가_이미지가아니면_이미지가아니라고_에러가_뜬다() {
        // given
        let dispatch = XCTestExpectation()
        let expectation = ImageSearchError.imageDataIsWrong.errorDescription
        var resultToExpect = ""

        // when
        imageSearcherUnderTeest.fetch(about: "notAnImage") { result in
            switch result {
            case .success(let image):
                XCTFail(image.description)
            case .failure(let error):
                guard let error = error as? ImageSearchError else {
                    XCTFail(error.localizedDescription)
                    return
                }

                resultToExpect = error.errorDescription
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertEqual(expectation, resultToExpect)
    }

    func test_요청에대한응답에서_thumbnail의_데이터가_이미지면_성공이다() {
        // given
        let dispatch = XCTestExpectation()
        let expectation = CGFloat.zero
        var resultToExpect = CGFloat.leastNormalMagnitude

        // when
        imageSearcherUnderTeest.fetch(about: "goodImage") { result in
            switch result {
            case .success(let image):
                resultToExpect = image.size.width
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        XCTAssertGreaterThan(resultToExpect, expectation)
    }
}
