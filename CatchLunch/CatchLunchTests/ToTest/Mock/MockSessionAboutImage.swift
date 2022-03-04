//
//  MockSessionAboutImage.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/04.
//
import Foundation
@testable import CatchLunch

extension URLRequest {
    static let failToParse = URLRequest(url: URL(string: "failToParse")!)
    static let emptyResponse = URLRequest(url: URL(string: "emptyResponse")!)
    static let emptyLink = URLRequest(url: URL(string: "emptyLink")!)
    static let invalidLink = URLRequest(url: URL(string: "invalidLink")!)
    static let invaildData = URLRequest(url: URL(string: "invaildData")!)
    static let notAnImage = URLRequest(url: URL(string: "notAnImage")!)
    static let goodImage = URLRequest(url: URL(string: "goodImage")!)
}

final class MockSessionAboutImage: Sessionable {
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
        case .goodImage:
            setUpHandler(with: 200, data: goodDummyData)
        case .failToParse:
            setUpHandler(with: 200, data: invalidDummayData)
        case .emptyResponse:
            setUpHandler(with: 200, data: emptyResultDummyData)
        case .emptyLink:
            setUpHandler(with: 200, data: emptyLinkDummyData)
        case .invalidLink:
            setUpHandler(with: 200, data: invalidLinkDummyData)
        case .invaildData:
            setUpHandler(with: 200, data: emptyData)
        case .notAnImage:
            setUpHandler(with: 200, data: notImageDummyData)
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

    private var goodDummyData: Data {
        let jsonString = goodDummyImageSearchResult
        return jsonString.data(using: .utf8)!
    }

    private var invalidDummayData: Data {
        let jsonString = invalidDummyImageSearchResult
        return jsonString.data(using: .utf8)!
    }
    
    private var emptyResultDummyData: Data {
        let jsonString = dummyImageSearchResultWithEmptyItems
        return jsonString.data(using: .utf8)!
    }

    private var emptyLinkDummyData: Data {
        let jsonString = dummyImageSearchResultWithEmptyLink
        return jsonString.data(using: .utf8)!
    }

    private var invalidLinkDummyData: Data {
        let jsonString = dummyImageSearchResultWithInvalidData
        return jsonString.data(using: .utf8)!
    }

    private var notImageDummyData: Data {
        let jsonString = dummyImageSearchResultWithWrongData
        return jsonString.data(using: .utf8)!
    }
}

fileprivate final class MockURLProtocol: URLProtocol {
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
