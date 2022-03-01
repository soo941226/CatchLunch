//
//  MockRestaurantNetworkManager.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import Foundation
@testable import CatchLunch

final class MockRestaurantNetworkManager: NetworkManagable {
    static let just = "just"
    private(set) var request: URLRequest?
    private(set) var session: MockSession

    init(session: MockSession = MockSession()) {
        self.session = session
    }

    func setUpRequest(with request: URLRequest) {
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
        
        asyncAfter {
            self.session.dataTask(with: request) { data, response, error in
                switch request {
                case .dataIsNotExist:
                    completionHandler(.success(self.incorrectData))
                case .clientError:
                    completionHandler(.failure(NetworkError.clientError(code: 400)))
                case .serverError:
                    completionHandler(.failure(NetworkError.serverError(code: 500)))
                case .otherResponseError:
                    completionHandler(.failure(NetworkError.dataIsNotExist))
                case .criticalError:
                    completionHandler(.failure(NetworkError.dataIsNotExist))
                default:
                    completionHandler(.success(self.correctData))
                }
            }.resume()
        }
    }

    private func asyncAfter(_ then: @escaping () -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            then()
        }
    }
}
