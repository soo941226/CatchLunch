//
//  TestGyeonggiRestaurantSearchViewModel.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/01.
//


import XCTest
@testable import CatchLunch

final class TestGyeonggiRestaurantViewModel: XCTestCase {
    private var viewModelUnderTest: GyeonggiRestaurantViewModel<MockRestaurantSearcher>!

    override func setUp() {
        viewModelUnderTest = GyeonggiRestaurantViewModel(service: MockRestaurantSearcher())
    }

    override func tearDown() {
        viewModelUnderTest = nil
    }

    func test_viewModel이_기본상태일때에는_count가_0이다() {
        //just
        XCTAssertEqual(viewModelUnderTest.count, .zero)
    }

    func test_viewModel이_기본상태일때_subcript에_어떤indext를넣어도_nil이나온다() {
        //just
        XCTAssertNil(viewModelUnderTest[0])
        XCTAssertNil(viewModelUnderTest[10])
        XCTAssertNil(viewModelUnderTest[100])
        XCTAssertNil(viewModelUnderTest[1000])
    }

    func test_viewModel이_fetch를1번하면_아이템이_10개이하다() {
        //given
        let expectation = XCTestExpectation(description: "expectation")

        //when
        viewModelUnderTest.fetch { isSuccess in
            //then
            if isSuccess {
                XCTAssertLessThanOrEqual(self.viewModelUnderTest.count, 10)
            } else {
                XCTFail("fetch failed")
            }

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func test_viewModel에_fetch를_동시에_반복해서_호출해도_1번만_동작하고_아이템을_잘_가져온다() {
        //given
        let reulstToExpect = 10
        let expectation = XCTestExpectation(description: "expectation")

        //when
        for _ in 0...10 {
            viewModelUnderTest.fetch { isSuccess in
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)

        //then
        XCTAssertEqual(viewModelUnderTest.count, reulstToExpect)
        XCTAssertNotNil(viewModelUnderTest[viewModelUnderTest.count-1])
        XCTAssertNil(viewModelUnderTest[viewModelUnderTest.count])
    }

    func test_viewModel에_fetch를_연달아_반복해서_호출하다가_아이템을_다_가져오면_더이상_갱신하지_않는다() {
        //given
        func recursiveFetch(
            with expectation: XCTestExpectation,
            until to: Int,
            from: Int = .zero
        ) {
            viewModelUnderTest.fetch { _ in
                let from = from + 1
                if from == to {
                    expectation.fulfill()
                } else {
                    recursiveFetch(with:expectation, until: to, from: from)
                }
            }
        }
        let maximumDummyCount = 25
        let expectation = XCTestExpectation(description: "expectation")

        //when
        recursiveFetch(with: expectation, until: 4)

        //then
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(viewModelUnderTest.count, maximumDummyCount)
    }
}

