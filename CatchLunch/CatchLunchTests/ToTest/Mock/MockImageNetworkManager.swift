//
//  MockImageNetworkManager.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/27.
//

import Foundation
@testable import CatchLunch

final class MockImageNetworkManager: NetworkManagable {
    static let stateOnWrongSearchResult = "blah"
    static let stateOnItemsIsNotExists = "blahblah"
    static let stateOnLinkIsNotExists = "blahblahblah"
    static let stateOnWrongURL = "blahblahblahblah"
    static let stateOnWrongImageData = "blahblahblahblahblah"

    private(set) var request: URLRequest?
    private(set) var session: MockSession

    init(session: MockSession = MockSession()) {
        self.session = session
    }

    func setUpRequest(with request: URLRequest) {
        self.request = request
    }

    func dataTask(completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard let request = request else {
            completionHandler(.failure(NetworkError.requestIsNotExist))
            return
        }

        session.dataTask(with: request) { data, response, error in
            switch request {
            case .dataIsNotExist:
                completionHandler(.failure(NetworkError.dataIsNotExist))
            case .clientError:
                completionHandler(.failure(NetworkError.clientError(code: 400)))
            case .serverError:
                completionHandler(.failure(NetworkError.serverError(code: 500)))
            case .otherResponseError:
                completionHandler(.failure(NetworkError.dataIsNotExist))
            case .criticalError:
                completionHandler(.failure(NetworkError.dataIsNotExist))
            default:
                guard let key = request.allHTTPHeaderFields?.keys.first else {
                    return
                }
                self.dataIsExist(key, with: completionHandler)
            }
        }.resume()
    }

    private func dataIsExist(
        _ flag: String,
        with completionHandler: @escaping (Result<Data, Error>) -> Void
    ) {
        switch flag {
        case Self.stateOnWrongSearchResult:
            completionHandler(.success(Data()))
        case Self.stateOnItemsIsNotExists:
            completionHandler(.success(dataAboutItemsIsNotExists))
        case Self.stateOnLinkIsNotExists:
            completionHandler(.success(dataAboutLinkIsNotExists))
        case Self.stateOnWrongURL:
            completionHandler(.success(dataAboutUrlIsWrong))
        case Self.stateOnWrongImageData:
            completionHandler(.success(dataAboutImageDataIsWrong))
        default:
            completionHandler(.success(validData))
        }
    }


    private let encoder = JSONEncoder()

    private var dataAboutItemsIsNotExists: Data {
        let value = ImageSearchResult(items: [])
        return try! encoder.encode(value)
    }

    private var dataAboutLinkIsNotExists: Data {
        let value = ImageSearchResult(items: [.init(thumbnail: nil)])
        return try! encoder.encode(value)
    }
    private var dataAboutUrlIsWrong: Data {
        let value = ImageSearchResult(items: [.init(thumbnail: "fjpsddgiajfiphjagsp")])
        return try! encoder.encode(value)
    }

    private var dataAboutImageDataIsWrong: Data {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "dummyText", ofType: ".txt") else {
            fatalError("invalid path")
        }

        let value = ImageSearchResult(items: [.init(thumbnail: "file://"+path)])
        return try! encoder.encode(value)
    }

    private var validData: Data {
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.path(forResource: "dummyImage", ofType: ".jpg") else {
            fatalError("invalid path")
        }

        let value = ImageSearchResult(items: [.init(thumbnail: "file://"+path)])
        return try! encoder.encode(value)
    }
}
