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
    case dataIsExist
    case dataIsNotExist
    case clientError
    case serverError
    case otherResponseError
    case criticalError
}

final class MockSession: Sessionable {
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

        func resume() {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                switch status {
                case .dataIsExist:
                    completionHandler(Data(), nil, nil)
                case .dataIsNotExist:
                    completionHandler(nil, nil, nil)
                case .clientError:
                    guard let url = URL(string: MockSession.dummyURL) else {
                        completionHandler(nil, nil, DummyError.canNotCreateURL)
                        return
                    }

                    let dummyResponse = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
                    completionHandler(nil, dummyResponse, nil)
                case .serverError:
                    guard let url = URL(string: MockSession.dummyURL) else {
                        completionHandler(nil, nil, DummyError.canNotCreateURL)
                        return
                    }

                    let dummyResponse = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
                    completionHandler(nil, dummyResponse, nil)
                case .otherResponseError:
                    guard let url = URL(string: MockSession.dummyURL) else {
                        completionHandler(nil, nil, DummyError.canNotCreateURL)
                        return
                    }

                    let dummyResponse = HTTPURLResponse(url: url, statusCode: 999, httpVersion: nil, headerFields: nil)
                    completionHandler(nil, dummyResponse, nil)
                case .criticalError:
                    completionHandler(nil, nil, DummyError.justError)
                }
            }
        }
        func cancel() {}
        func suspend(){}
    }
}


/*
 1. 목세션을 NetworkManager에 주입해서 NetworkManager를 테스트 하고 싶음
 2. 네트워크 매니저에 completionHandler

 */
