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
    private var session: MockSessionAboutImage

    init(session: MockSessionAboutImage = MockSessionAboutImage()) {
        self.session = session
    }

    func setUpRequest(with request: URLRequest) {
        let query = request
            .url?
            .query?
            .split(separator: "&")
            .filter({ substring in
                let range = substring.range(of: "query")
                return range != nil
            })
            .first?
            .split(separator: "=")
            .last
        let searchParam = String(query ?? "")

        switch searchParam {
        case "goodImage":
            self.request = .goodImage
        case "failToParse":
            self.request = .failToParse
        case "emptyResponse":
            self.request = .emptyResponse
        case "emptyLink":
            self.request = .emptyLink
        case "invalidLink":
            self.request = .invalidLink
        case "invaildData":
            self.request = .invaildData
        case "notAnImage":
            self.request = .notAnImage
        default:
            self.request = request
        }
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
