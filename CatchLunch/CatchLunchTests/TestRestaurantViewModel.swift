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
        //just
        XCTAssertNil(viewModelUnderTest[0])
    }

    func test_fetch가_성공한_후에는_subsript로_접근하면_아이템이_존재한다() {
        let dispatch = XCTestExpectation()
        viewModelUnderTest.fetch { isSuccess in
            if isSuccess {
                XCTAssertNotNil(self.viewModelUnderTest[0])
                XCTAssertGreaterThan(self.viewModelUnderTest[0]!.image.size.width, .zero)
                XCTAssertGreaterThan(self.viewModelUnderTest[0]!.image.size.height, .zero)
            } else {
                XCTFail(self.viewModelUnderTest.error!.localizedDescription)
            }
            dispatch.fulfill()
        }
        wait(for: [dispatch], timeout: 5.0)
    }

    func test_fetch를_연달아해도_쓰로틀링이_걸려서_한번만_동작한다() {
        let dispatch = XCTestExpectation()
        let expectaion = 10

        for _ in 0..<10 {
            viewModelUnderTest.fetch { isSuccess in
                if isSuccess {
                    XCTAssertNotNil(self.viewModelUnderTest[0])
                    XCTAssertGreaterThan(self.viewModelUnderTest[0]!.image.size.width, .zero)
                    XCTAssertGreaterThan(self.viewModelUnderTest[0]!.image.size.height, .zero)
                } else {
                    XCTFail(self.viewModelUnderTest.error!.localizedDescription)
                }
                dispatch.fulfill()
            }
        }

        wait(for: [dispatch], timeout: 5.0)
        XCTAssertEqual(viewModelUnderTest.count, expectaion)
        XCTAssertNil(viewModelUnderTest[expectaion+1])
    }

    func test_viewModel의_fetch중_어떻게든_에러가_나오면_에러를_저장해놓는다() {
        //given
        let disaptch = XCTestExpectation()
        var resultToExpect: Error?
        func recursiveFetch(with dispatch: XCTestExpectation, to: Int, from: Int = .zero) {
            viewModelUnderTest.fetch { isSuccess in
                let from = from + 1
                if from == to {
                    if isSuccess {
                        XCTFail(self.viewModelUnderTest.count.description)
                    } else {
                        resultToExpect = self.viewModelUnderTest.error
                    }
                    dispatch.fulfill()
                } else {
                    recursiveFetch(with: dispatch, to: to, from: from)
                }
            }
        }

        //when
        recursiveFetch(with: disaptch, to: 5)
        wait(for: [disaptch], timeout: 10)

        //then
        XCTAssertNotNil(resultToExpect)
    }
}
