//
//  DaumImageSearcher.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/18.
//

import UIKit

final class DaumImageSearcher: AbstarctImageSearcher {

    private func nextRequest(about name: String) -> URLRequest {
        var urlComponent = URLComponents(string: DaumAPIConfig.httpURL)!
        urlComponent.queryItems = [
            .init(name: "query", value: name),
            .init(name: "size", value: "1")
        ]

        var request = URLRequest(url: urlComponent.url!)
        request.setValue(
            HiddenConfiguration.daumAPIKey.value,
            forHTTPHeaderField: HiddenConfiguration.daumAPIKey.key
        )
        return request
    }

    override func fetch(
        about name: String,
        completionHandler: @escaping (Result<UIImage, Error>) -> Void
    ) {
        let request = nextRequest(about: name)
        manager.setUpRequest(with: request)
        manager.dataTask { [weak self] result in
            switch result {
            case .success(let data):
                guard let response = try? self?.decoder.decode(
                    DaumImageSearchResult.self, from: data
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

private enum DaumAPIConfig {
    static let httpURL = "https://dapi.kakao.com/v2/search/image"
}
