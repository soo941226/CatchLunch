//
//  MockSession.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/02/25.
//

import Foundation
@testable import CatchLunch

extension URLRequest {
    static let emptyResaurantData = URLRequest(url: URL(string: "empty_row")!)
    static let wrongDataRequest = URLRequest(url: URL(string: "wrong_dummy")!)
    static let dummyRestaurantData = URLRequest(url: URL(string: "good_dummy")!)
    static let dataIsNotExist = URLRequest(url: URL(string: "be_error1")!)
    static let clientError = URLRequest(url: URL(string: "be_error2")!)
    static let serverError = URLRequest(url: URL(string: "be_error3")!)
    static let otherResponseError = URLRequest(url: URL(string: "be_error4")!)
    static let errorRequest = URLRequest(url: URL(string: "be_error5")!)
}

final class MockSession: Sessionable {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        setUpRequest(with: request)
        return URLSession(
            configuration: configuration
        ).dataTask(with: request, completionHandler: completionHandler)
    }

    private func setUpRequest(with request: URLRequest) {
        switch request {
        case .dataIsNotExist:
            setUpHandler(with: 200, data: emptyData)
        case .clientError:
            setUpHandler(with: 400, data: emptyData)
        case .serverError:
            setUpHandler(with: 500, data: emptyData)
        case .otherResponseError:
            setUpHandler(with: .zero, data: emptyData)
        case .errorRequest:
            setUpHandler(with: .min, data: emptyData)
        case .dummyRestaurantData:
            setUpHandler(with: 200, data: restaurantDummyData)
        case .wrongDataRequest:
            setUpHandler(with: 200, data: wrongDummyData)
        case .emptyResaurantData:
            setUpHandler(with: 200, data: emptyDummyData)
        default:
            setUpHandler(with: 200, data: emptyData)
        }
    }

    private func setUpHandler(with code: Int, data: Data) {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!, statusCode: code,
                httpVersion: nil, headerFields: nil
            )

            return (response!, data)
        }
    }

    private var emptyData: Data {
        return Data()
    }

    private var emptyDummyData: Data {
        let jsonString = dummyGyeonggiAPIResultWithEmptyData
        return jsonString.data(using: .utf8)!
    }

    private var wrongDummyData: Data {
        let jsonString = dummyGyeonggiAPIResultWithWrongFormmat
        return jsonString.data(using: .utf8)!
    }

    private var restaurantDummyData: Data {
        let jsonString = dummyGyeonggiAPIResultWithCount10
        return jsonString.data(using: .utf8)!
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
