//
//  MockNaverImageSearcher.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/04.
//

import UIKit
@testable import CatchLunch

struct MockNaverImageSearcher: SingleItemSearchService {
    typealias Response = UIImage
    private let manager: NetworkManagable
    private let decoder = JSONDecoder()

    init(manager: NetworkManagable = MockImageNetworkManager()) {
        self.manager = manager
    }

    private func nextRequest(about name: String) -> URLRequest {
        var urlComponent = URLComponents(string: NaverAPIConfig.httpURL)!
        urlComponent.queryItems = [
            .init(name: "query", value: name),
            .init(name: "display", value: "1"),
            .init(name: "sort", value: "sim"),
            .init(name: "filter", value: "medium")
        ]

        var request = URLRequest(url: urlComponent.url!)
        request.setValue(
            HiddenConfiguration.naverAPIID.value,
            forHTTPHeaderField: HiddenConfiguration.naverAPIID.key
        )
        request.setValue(
            HiddenConfiguration.naverAPIKey.value,
            forHTTPHeaderField: HiddenConfiguration.naverAPIKey.key
        )
        return request
    }

    func fetch(
        about name: String,
        completionHandler: @escaping (Result<UIImage, Error>) -> Void
    ) {
        let request = nextRequest(about: name)
        manager.setUpRequest(with: request)
        manager.dataTask { result in
            switch result {
            case .success(let data):
                guard let response = try? decoder.decode(
                    ImageSearchResult.self, from: data
                ) else {
                    return completionHandler(.failure(ImageSearchError.searchResultIsWrong))
                }

                guard let items = response.items, let first = items.first else {
                    return completionHandler(.failure(ImageSearchError.itemsIsNotExists))
                }

                guard let link = first.thumbnail,
                      let url = URL(string: link) else {
                          return completionHandler(.failure(ImageSearchError.linkIsNotExists))
                      }

                guard let data = try? Data(contentsOf: url) else {
                    return completionHandler(.failure(ImageSearchError.urlIsWrong))
                }

                guard let image = UIImage(data: data) else {
                    return completionHandler(.failure(ImageSearchError.imageDataIsWrong))
                }

                completionHandler(.success(image))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

@frozen enum ImageSearchError: LocalizedError {
    case searchResultIsWrong
    case itemsIsNotExists
    case linkIsNotExists
    case urlIsWrong
    case imageDataIsWrong

    var errorDescription: String {
        switch self {
        case .searchResultIsWrong:
            return "응답 에러"
        case .itemsIsNotExists:
            return "items가 없옴"
        case .linkIsNotExists:
            return "응답이 잘 왔는데 내부에 링크가 없음"
        case .urlIsWrong:
            return "응답이 잘 왔는데 내부 링크가 이상함"
        case .imageDataIsWrong:
            return "링크로 이미지 가져왔더니 이상함"
        }
    }
}

fileprivate enum NaverAPIConfig {
    static let httpURL = "https://openapi.naver.com/v1/search/image"
}
