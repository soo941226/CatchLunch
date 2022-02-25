//
//  NetworkManager.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

final class NetworkManager: NetworkManagable<URLRequest> {
    private let session: URLSession

    override init() {
        self.session = URLSession(configuration: .default)
    }

    override func dataTask(
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {

        guard let request = request else {
            completionHandler(.failure(NetworkError.requestIsNotExist))
            return
        }

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }

            guard let data = data else {
                completionHandler(.failure(NetworkError.dataIsNotExist))
                return
            }

            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 400..<500:
                    completionHandler(.failure(NetworkError.clientError(
                        code: response.statusCode,
                        description: response.description
                    )))
                    return
                case 500..<600:
                    completionHandler(.failure(NetworkError.serverError(
                        code: response.statusCode,
                        description: response.description
                    )))
                    return
                default:
                    break
                }
            }

            completionHandler(.success(data))
        }
    }
}
