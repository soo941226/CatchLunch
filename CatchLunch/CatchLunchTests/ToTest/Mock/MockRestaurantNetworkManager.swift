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

    var correctDummyData: Data {
        let jsonString = dummyRestaurants
        return jsonString.data(using: .utf8)!
    }
    
    var incorrectData: Data {
        return Data()
    }
    
    func dataTask(
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let request = request else {
            return completionHandler(.failure(NetworkError.requestIsNotExist))
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
                    completionHandler(.success(self.correctDummyData))
                }
            }.resume()
        }
    }
}
