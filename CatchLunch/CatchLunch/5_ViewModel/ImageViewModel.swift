//
//  ImageViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/04.
//

import UIKit

final class ImageViewModel<Service: SingleItemSearchService>: NameSearchViewModelable {
    private let service: Service
    private(set) var error: Error?
    private let cachedImages: NSCache<NSString, UIImage>

    init(service: Service) {
        self.service = service
        cachedImages = NSCache()
        cachedImages.countLimit = 50
    }

    subscript(_ name: String) -> UIImage? {
        return cachedImages.object(forKey: name as NSString)
    }

    func fetch(about name: String, completionHandler: @escaping (Bool) -> Void) {
        let nsName = name as NSString

        if cachedImages.object(forKey: nsName) != nil {
            return completionHandler(true)
        }

        service.fetch(about: name) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                let response = response as! UIImage
                self.cachedImages.setObject(response, forKey: nsName)
                completionHandler(true)
            case .failure(let error):
                self.error = error
                completionHandler(false)
            }
        }
    }
}
