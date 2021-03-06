//
//  TestImageViewModel.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/04.
//

import XCTest
@testable import CatchLunch

final class TestImageViewModel: XCTestCase {
    private var viewModelUnderTest: ImageViewModel!

    override func setUp() {
        viewModelUnderTest = ImageViewModel(service: MockNaverImageSearcher())
    }

    override func tearDown() {
        viewModelUnderTest = nil
    }

    func test_fetch이전에_viewModel의_subscript로접근하면_placeHolder가_나온다() {
        // just
        XCTAssertEqual(viewModelUnderTest["goodImage"], viewModelUnderTest.placeHolder)
    }

    func test_fetch_성공_이후에_viewModel의_subscript로접근하면_이미지가_잘_나온다() {
        // given
        setUpHandler(data: StubImageSearchResult().goodObject, code: 200)
        let dispatch = XCTestExpectation()
        let findImageName = "goodImage"

        // when
        viewModelUnderTest.search(about: findImageName) { isSuccess in
            if isSuccess {
                // then
                XCTAssertNotNil(self.viewModelUnderTest[findImageName])
                XCTAssertTrue(true, self.viewModelUnderTest[findImageName].description)
            } else {
                XCTFail(self.viewModelUnderTest.error!.localizedDescription)
            }
            dispatch.fulfill()
        }

        wait(for: [dispatch], timeout: 5.0)
    }

    func test_fetch_실패_이후에_viewModel_error로_접근하면_에러가_남아있다() {
        // given
        setUpHandler(data: StubImageSearchResult().wrongDataObject, code: 400)
        let dispatch = XCTestExpectation()
        let wrongImageName = "notAnImage"

        // when
        viewModelUnderTest.search(about: wrongImageName) { isSuccess in
            if isSuccess {
                XCTFail("성공하면안됨")
            } else {
                // then
                XCTAssertNotNil(self.viewModelUnderTest.error)
                XCTAssertTrue(true, self.viewModelUnderTest.error!.localizedDescription)
            }
            dispatch.fulfill()
        }

        wait(for: [dispatch], timeout: 5.0)
    }

    func test_한번_요청을해서_가져온_이미지는_캐싱하여_동기적으로_곧장_가져올_수_있다() {
        // given
        setUpHandler(data: StubImageSearchResult().goodObject, code: 200)
        let dispatch = XCTestExpectation()
        let findImageName = "DummyImage"
        var expectation: UIImage?
        var resultToExpect: UIImage?

        // when
        viewModelUnderTest.search(about: findImageName) { isSuccess in
            if isSuccess {
                expectation = self.viewModelUnderTest[findImageName]
            } else {
                XCTAssertNotNil(self.viewModelUnderTest.error)
                XCTFail(self.viewModelUnderTest.error!.localizedDescription)
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)

        // then
        viewModelUnderTest.search(about: findImageName) { isSuccess in
            if isSuccess {
                resultToExpect = self.viewModelUnderTest[findImageName]
            } else {
                XCTAssertNotNil(self.viewModelUnderTest.error)
                XCTFail(self.viewModelUnderTest.error!.localizedDescription)
            }
        }
        XCTAssertEqual(expectation, resultToExpect)
    }
}
