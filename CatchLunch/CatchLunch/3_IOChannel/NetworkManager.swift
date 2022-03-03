//
//  NetworkManager.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

final class NetworkManager: NetworkManagable {
    private var session: Sessionable
    private var request: URLRequest?

    init(session: Sessionable = URLSession(configuration: .default)) {
        self.session = session
    }

    func setUpRequest(with request: URLRequest) {
        self.request = request
    }

    func dataTask(
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let request = request else {
            return completionHandler(.failure(NetworkError.requestIsNotExist))
        }

        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            self.request = nil

            if let error = error {
                return completionHandler(.failure(error))
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
