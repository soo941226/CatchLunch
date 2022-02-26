//
//  MockNetworkManager.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import Foundation
@testable import CatchLunch

final class MockNetworkManager: NetworkManagable {
    private(set) var request: MockSessionStatus?
    private(set) var session: MockSession

    init(session: MockSession = MockSession()) {
        self.session = session
    }

    func setUpRequest(with request: MockSessionStatus) {
        self.request = request
    }

    var correctData: Data {
        let response = StubJsonToTest(
            cityName: "가평군",
            restaurantName: "가평축협 한우명가",
            phoneNumber: "031-581-1592",
            mainFoodNames: "푸른연잎한우명품꽃등심",
            refinedZipCode: "12422",
            roadNameAddress: "경기도 가평군 가평읍 달전로 19",
            locationNameAddress: "경기도 가평군 가평읍 달전리 382-1번지",
            latitude: "37.8158443",
            longitude: "127.5161283"
        )

        let jsonString = "[\(response.jsonString)]"
        return jsonString.data(using: .utf8)!
    }
    
    var incorrectData: Data {
        return Data()
    }
    
    func dataTask(
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let request = request else {
            completionHandler(.failure(NetworkError.requestIsNotExist))
            return
        }

        switch request {
        case .dataIsExist:
            asyncAfter {
                completionHandler(.success(self.correctData))
            }
        case .dataIsNotExist:
            asyncAfter {
                completionHandler(.success(self.incorrectData))
            }
        default:
            asyncAfter {
                completionHandler(.failure(NetworkError.dataIsNotExist))
            }
        }
    }

    private func asyncAfter(_ then: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            then()
        }
    }
}
