//
//  NaverImageSearcher.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import UIKit

struct NaverImageSearcher: SingleItemSearchService {
    typealias Response = UIImage
    private let manager: NetworkManagable
    private let decoder = JSONDecoder()

    init(manager: NetworkManagable = NetworkManager()) {
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
                      let url = URLFactory.make(from: link) else {
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

private enum NaverAPIConfig {
    static let httpURL = "https://openapi.naver.com/v1/search/image"
}
