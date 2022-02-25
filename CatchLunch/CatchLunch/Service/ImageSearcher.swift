//
//  ImageSearcher.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//
import UIKit

final class ImageSearcher<NetworkManager: NetworkManagable>: ImageSearchService {
    typealias Requestable = NetworkManager.Requestable
    private(set) var manager: NetworkManager

    init(manager: NetworkManager) {
        self.manager = manager
    }

    func setUpRequest(request: Requestable) {
        manager.setUpRequest(with: request)
    }

    func fetchImage(
        about name: String,
        completionHandler: @escaping (Result<UIImage, Error>) -> Void
    ) {
        manager.dataTask { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completionHandler(.failure(NetworkError.dataIsNotExist))
                    return
                }

                completionHandler(.success(image))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
