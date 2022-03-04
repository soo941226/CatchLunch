//
//  MockRestaurantNetworkManager.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import Foundation
@testable import CatchLunch

final class MockRestaurantNetworkManager: NetworkManagable {
    private var request: URLRequest?
    private var session: MockSessionAboutRestaurant

    init(session: MockSessionAboutRestaurant = MockSessionAboutRestaurant()) {
        self.session = session
    }

    func setUpRequest(with request: URLRequest) {
        let pageSizeQuery = request.url!.query?
            .split(separator: "&")
            .filter({ substirng in
                let index = substirng.range(of: "pSize")
                return index == nil ? false : true
            })[0]
        let string = pageSizeQuery!.split(separator: "=").last!.description
        let pageSize = Int(string)!

        guard pageSize > .zero else {
            return self.request = .emptyResaurantData
        }

        let pageIndexQuery = request.url!.query?
            .split(separator: "&")
            .filter({ substirng in
                let index = substirng.range(of: "pIndex")
                return index == nil ? false : true
            })[0]
        let numberString1 = pageIndexQuery!.split(separator: "=")[1].description
        let pageIndex = Int(numberString1)!

        if pageIndex < 0 {
            self.request = .clientError
        } else if pageIndex == 0 {
            self.request = .dataIsNotExist
        } else if 1...3 ~= pageIndex {
            self.request = .dummyRestaurantData
        } else if pageIndex == .max, pageSize == .max {
            self.request = .wrongDataRequest
        } else {
            self.request = .serverError
        }
    }

    func dataTask(
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let request = request else {
            return completionHandler(.failure(NetworkError.requestIsNotExist))
        }

        asyncAfter {
            self.session.dataTask(with: request) { data, response, error in
                self.request = nil
                if let error = error {
                    completionHandler(.failure(error))
                }

                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200..<300:
                        break
                    case 400..<500:
                        return completionHandler(.failure(NetworkError.clientError(
                            code: response.statusCode
                        )))
                    case 500..<600:
                        return completionHandler(.failure(NetworkError.serverError(
                            code: response.statusCode
                        )))
                    default:
                        return completionHandler(.failure(NetworkError.uknownError(
                            code: response.statusCode
                        )))
                    }
                }

                if let data = data {
                    if data.isEmpty {
                        completionHandler(.failure(NetworkError.dataIsNotExist))
                    } else {
                        completionHandler(.success(data))
                    }
                } else {
                    completionHandler(.failure(NetworkError.dataIsNotExist))
                }
            }.resume()
        }
    }
}
