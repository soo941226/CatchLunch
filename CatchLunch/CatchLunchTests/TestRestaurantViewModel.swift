//
//  TestRestaurantViewModel.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/01.
//

import XCTest
@testable import CatchLunch

final class TestRestaurantViewModel: XCTestCase {
    private var viewModelUnderTest: RestaurantsViewModel<MockGyeonggiRestaurantSearcher>!

    override func setUp() {
        viewModelUnderTest = RestaurantsViewModel(service: MockGyeonggiRestaurantSearcher())
    }

    override func tearDown() {
        viewModelUnderTest = nil
    }

    func test_fetch_이전에_viewModel의_subscript로_접근하면_nil이_나온다() {
        // just
        XCTAssertNil(viewModelUnderTest[0])
    }

    func test_fetch_이전에_nextIndexPaths에_접근하면_빈_배열이_나온다() {
        // just
        XCTAssertEqual(viewModelUnderTest.nextIndexPaths.count, .zero)
    }

    func test_fetch가_성공한_후에는_subsript로_접근하면_아이템이_존재한다() {
        //given
        setUpHandler(data: StubGyeonggiAPIResult().objectWithCount10, code: 200)
        let dispatch = XCTestExpectation()

        //when
        viewModelUnderTest.search { isSuccess in
            if isSuccess {
                dispatch.fulfill()
            } else {
                XCTFail(self.viewModelUnderTest.error!.localizedDescription)
            }

        }
        wait(for: [dispatch], timeout: 5.0)

        //then
        XCTAssertNotNil(viewModelUnderTest[0])
    }

    func test_fetch를_연달아해도_쓰로틀링이_걸려서_한번만_동작한다() {
        //given
        setUpHandler(data: StubGyeonggiAPIResult().objectWithCount10, code: 200)
        let dispatch = XCTestExpectation()
        let expectaion = 10

        //when
        for _ in 0..<10 {
            viewModelUnderTest.search { isSuccess in
                if isSuccess {
                    dispatch.fulfill()
                } else {
                    XCTFail(self.viewModelUnderTest.error!.localizedDescription)
                }

            }
        }
        wait(for: [dispatch], timeout: 5.0)

        //then
        XCTAssertNil(viewModelUnderTest[expectaion+1])
        XCTAssertNotNil(self.viewModelUnderTest[0])
    }

    func test_viewModel의_fetch중_어떻게든_에러가_나오면_에러를_저장해놓는다() {
        // given
        setUpHandler(data: Data(), code: 400)
        let dispatch = XCTestExpectation()
        var resultToExpect: Error?
        viewModelUnderTest.search { isSuccess in
            if isSuccess {
                XCTFail(self.viewModelUnderTest.debugDescription)
            } else {
                resultToExpect = self.viewModelUnderTest.error
            }
            dispatch.fulfill()
        }

        // when
        wait(for: [dispatch], timeout: 10)

        // then
        XCTAssertNotNil(resultToExpect)
    }

    func test_viewModel의_fetch이후_결과데이터의갯수가_0이면_에러없이_더이상_fetch의_후행클로저가_동작하지_않는다() {
        // given
        setUpHandler(data: StubGyeonggiAPIResult().objectWithCount0, code: 200)
        let dispatch = XCTestExpectation()
        var resultToExpect: Error?

        viewModelUnderTest.search { isSuccess in
            if isSuccess {
                XCTFail(self.viewModelUnderTest.debugDescription)
            } else {
                resultToExpect = self.viewModelUnderTest.error
            }
            dispatch.fulfill()
        }

        // when
        wait(for: [dispatch], timeout: 10)

        // then
        XCTAssertNil(resultToExpect)
        viewModelUnderTest.search { _ in
            XCTFail("failed")
        }
    }
}
