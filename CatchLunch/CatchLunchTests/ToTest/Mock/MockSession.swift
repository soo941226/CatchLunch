//
//  MockSession.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import Foundation
@testable import CatchLunch

final class MockSession: Sessionable {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        setUpHandler(with: request)
        return URLSession(
            configuration: configuration
        ).dataTask(with: request, completionHandler: completionHandler)
    }

    private func setUpHandler(with request: URLRequest) {
        switch request {
        case .dataIsNotExist:
            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(
                    url: request.url!, statusCode: 200,
                    httpVersion: nil, headerFields: nil
                )

                return (response!, self.emptyData)
            }
        case .clientError:
            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(
                    url: request.url!, statusCode: 400,
                    httpVersion: nil, headerFields: nil
                )

                return (response!, Data())
            }
        case .serverError:
            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(
                    url: request.url!, statusCode: 500,
                    httpVersion: nil, headerFields: nil
                )

                return (response!, Data())
            }
        case .otherResponseError:
            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(
                    url: request.url!, statusCode: .zero,
                    httpVersion: nil, headerFields: nil
                )

                return (response!, Data())
            }
        case .errorRequest:
            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(
                    url: request.url!, statusCode: .min,
                    httpVersion: nil, headerFields: nil
                )

                return (response!, Data())
            }
        case .dummyRestaurantData:
            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(
                    url: request.url!, statusCode: 200,
                    httpVersion: nil, headerFields: nil
                )

                return (response!, self.restaurantDummyData)
            }
        default:
            MockURLProtocol.requestHandler = { request in
                let response = HTTPURLResponse(
                    url: request.url!, statusCode: .min,
                    httpVersion: nil, headerFields: nil
                )

                return (response!, Data())
            }
        }
    }

    private var restaurantDummyData: Data {
        let jsonString = dummyGyeonggiAPIResult
        return jsonString.data(using: .utf8)!
    }

    private var emptyData: Data {
        return Data()
    }
}

final class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    override func startLoading() {
        guard let handler = Self.requestHandler else {
            fatalError("you forgot to set the mock protocol request handler")
        }
        do {
            if request == .errorRequest {
                self.client?.urlProtocol(self, didFailWithError:NetworkError.uknownError(code: .zero))
                return
            }

            let (response, data) = try handler(request)
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: data)
            self.client?.urlProtocolDidFinishLoading(self)
        } catch {
            self.client?.urlProtocol(self, didFailWithError:error)
        }
    }
    override func stopLoading() {} // not interested
}

extension URLRequest {
    static let dummyRestaurantData: URLRequest = {
        return URLRequest(url: URL(string: "https://dataIsExist.com")!)
    }()
    static let dataIsNotExist: URLRequest = {
        return URLRequest(url: URL(string: "https://dataIsNotExist.com")!)
    }()
    static let clientError: URLRequest = {
        return URLRequest(url: URL(string: "https://clientError.com")!)
    }()
    static let serverError: URLRequest = {
        return URLRequest(url: URL(string: "https://serverError.com")!)
    }()
    static let otherResponseError: URLRequest = {
        return URLRequest(url: URL(string: "https://otherResponseError.com")!)
    }()
    static let errorRequest: URLRequest = {
        return URLRequest(url: URL(string: "https://errorRequest.com")!)
    }()
}
