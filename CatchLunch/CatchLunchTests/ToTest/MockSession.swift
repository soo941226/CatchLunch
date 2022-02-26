//
//  MockSession.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import Foundation
@testable import CatchLunch

enum DummyError: Error {
    case justError
    case canNotCreateURL
}

enum MockSessionStatus {
    case dataIsExist(flag: String)
    case dataIsNotExist
    case clientError
    case serverError
    case otherResponseError
    case criticalError
}

final class MockSession: Sessionable {
    static let just = "just"
    private static let dummyURL = "http://www.swift.com"

    func dataTask(
        with request: MockSessionStatus,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> DummyTask {
        return DummyTask(status: request, completionHandler)
    }

    struct DummyTask: Taskable {
        let status: MockSessionStatus
        let completionHandler: (Data?, URLResponse?, Error?) -> Void

        init(status: MockSessionStatus, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
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
                case .dataIsExist:
                    returnEmptyData()
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
                }
            }
        }
        func cancel() {}
        func suspend(){}
    }
}
