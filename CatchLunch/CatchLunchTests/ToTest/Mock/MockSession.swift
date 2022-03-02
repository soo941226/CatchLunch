//
//  MockSession.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import Foundation
@testable import CatchLunch

enum DummyError: LocalizedError {
    case justError
    case canNotCreateURL

    var errorDescription: String {
        switch self {
        case .justError:
            return "justError"
        case .canNotCreateURL:
            return "canNotCreateURL"
        }
    }
}

extension URLRequest {
    static func dataIsExist(flag: String) -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: "url")!)
        urlRequest.addValue(flag, forHTTPHeaderField: flag)
        return urlRequest
    }
    static let dataIsNotExist: URLRequest = {
        var urlRequest = URLRequest(url: URL(string: "dataIsNotExist")!)
        urlRequest.addValue("dataIsNotExist", forHTTPHeaderField: "dataIsNotExist")
        return urlRequest
    }()
    static let clientError: URLRequest = {
        var urlRequest = URLRequest(url: URL(string: "clientError")!)
        urlRequest.addValue("clientError", forHTTPHeaderField: "clientError")
        return urlRequest
    }()
    static let serverError: URLRequest = {
        var urlRequest = URLRequest(url: URL(string: "serverError")!)
        urlRequest.addValue("serverError", forHTTPHeaderField: "serverError")
        return urlRequest
    }()
    static let otherResponseError: URLRequest = {
        var urlRequest = URLRequest(url: URL(string: "otherResponseError")!)
        urlRequest.addValue("otherResponseError", forHTTPHeaderField: "otherResponseError")
        return urlRequest
    }()
    static let criticalError: URLRequest = {
        var urlRequest = URLRequest(url: URL(string: "criticalError")!)
        urlRequest.addValue("criticalError", forHTTPHeaderField: "criticalError")
        return urlRequest
    }()
}

final class MockSession: Sessionable {
    static let just = "just"
    private static let dummyURL = "http://www.swift.com"

    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> DummyTask {
        return DummyTask(status: request, completionHandler)
    }

    struct DummyTask: Taskable {
        let status: URLRequest
        let completionHandler: (Data?, URLResponse?, Error?) -> Void

        init(status: URLRequest, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
            self.status = status
            self.completionHandler = completionHandler
        }

        private func returnEmptyData() {
            completionHandler(Data(), nil, nil)
        }

        private func returnNil() {
            completionHandler(nil, nil, nil)
        }

        private func returnClientError() {
            guard let url = URL(string: MockSession.dummyURL) else {
                completionHandler(nil, nil, DummyError.canNotCreateURL)
                return
            }

            let dummyResponse = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
            completionHandler(nil, dummyResponse, nil)
        }

        private func returnServerError() {
            guard let url = URL(string: MockSession.dummyURL) else {
                completionHandler(nil, nil, DummyError.canNotCreateURL)
                return
            }

            let dummyResponse = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
            completionHandler(nil, dummyResponse, nil)
        }

        private func returnStrangeResponse() {
            guard let url = URL(string: MockSession.dummyURL) else {
                completionHandler(nil, nil, DummyError.canNotCreateURL)
                return
            }

            let dummyResponse = HTTPURLResponse(url: url, statusCode: 999, httpVersion: nil, headerFields: nil)
            completionHandler(nil, dummyResponse, nil)
        }

        private func returnJustError() {
            completionHandler(nil, nil, DummyError.justError)
        }

        func resume() {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                switch status {
                case .dataIsNotExist:
                    returnNil()
                case .clientError:
                    returnClientError()
                case .serverError:
                    returnServerError()
                case .otherResponseError:
                    returnStrangeResponse()
                case .criticalError:
                    returnJustError()
                default:
                    returnEmptyData()
                }
            }
        }
        func cancel() {}
        func suspend(){}
    }
}
