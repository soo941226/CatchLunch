//
//  NetworkManager.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

final class NetworkManager<
    Session: Sessionable
>: NetworkManagable{
    typealias Request = Session.Requestable
    private(set) var session: Session
    private(set) var request: Request?

    init(session: Session) {
        self.session = session
    }

    func setUpRequest(with request: Request) {
        self.request = request
    }

    func dataTask(
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

            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 400..<500:
                    completionHandler(.failure(NetworkError.clientError(
                        code: response.statusCode
                    )))
                    return
                case 500..<600:
                    completionHandler(.failure(NetworkError.serverError(
                        code: response.statusCode
                    )))
                    return
                default:
                    break
                }
            }

            if let data = data {
                completionHandler(.success(data))
            } else {
                completionHandler(.failure(NetworkError.dataIsNotExist))
            }
        }.resume()
    }
}
