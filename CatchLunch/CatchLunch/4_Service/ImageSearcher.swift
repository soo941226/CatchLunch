//
//  ImageSearcher.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//
import UIKit

struct ImageSearcher<NetworkManager: NetworkManagable>: SearchService {
    private(set) var manager: NetworkManager
    private let decoder = JSONDecoder()

    init(manager: NetworkManager) {
        self.manager = manager
    }

    func setUpRequest(request: URLRequest) {
        manager.setUpRequest(with: request)
    }

    func fetch(
        completionHandler: @escaping (Result<UIImage, Error>) -> Void
    ) {
        manager.dataTask { result in
            switch result {
            case .success(let data):
                guard let response = try? decoder.decode(
                    ImageSearchResult.self, from: data
                ) else {
                    return completionHandler(.failure(ImageSearchError.searchResultIsWrong))
                }

                guard let items = response.items, items.count >= 1 else {
                    return completionHandler(.failure(ImageSearchError.itemsIsNotExists))
                }

                guard let link = items[0].thumbnail, let url = URL(string: link) else {
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
