//
//  MockImageNetworkManager.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/27.
//

import Foundation
@testable import CatchLunch

final class MockImageNetworkManager: NetworkManagable {
    private var request: URLRequest?
    private var session: Sessionable

    init(session: Sessionable = MockSession()) {
        self.session = session
    }

    func setUpRequest(with request: URLRequest) {
        self.request = request
    }

    func dataTask(completionHandler: @escaping (Result<Data, Error>) -> Void) {
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
