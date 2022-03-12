//
//  MockURLProtocol.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/11.
//

import Foundation
@testable import CatchLunch

func setUpHandler(data: Data, code: Int, error: Error? = nil) {
    MockURLProtocol.requestHandler = { request in
        if let error = error {
            throw error
        }

        let response = HTTPURLResponse(
            url: request.url!, statusCode: code,
            httpVersion: nil, headerFields: nil
        )

        return (response!, data)
    }
}

final class MockURLProtocol: URLProtocol {
    fileprivate static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = Self.requestHandler else {
            fatalError("you must call setUpHandler(data:, code:) before test")
        }
        do {
            let (response, data) = try handler(request)
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            self.client?.urlProtocol(self, didLoad: data)
            self.client?.urlProtocolDidFinishLoading(self)
        } catch {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        Self.requestHandler = nil
    }

    override func stopLoading() {} // not interested
}

