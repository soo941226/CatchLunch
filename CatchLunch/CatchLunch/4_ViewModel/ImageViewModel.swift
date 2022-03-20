//
//  ImageViewModel.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/04.
//

import UIKit

final class ImageViewModel: NameSearchViewModelable {
    private let services: [AbstarctImageSearcher]
    private(set) var error: Error?
    private let cachedImages: NSCache<NSString, UIImage>

    init(service: AbstarctImageSearcher...) {
        self.services = service
        cachedImages = NSCache()
    }

    subscript(_ name: String) -> UIImage? {
        return cachedImages.object(forKey: name as NSString)
    }

    func fetch(about name: String, completionHandler: @escaping (Bool) -> Void) {
        let nsName = name as NSString

        if cachedImages.object(forKey: nsName) != nil {
            return completionHandler(true)
        }

        fetch(about: name, under: services.makeIterator(), completionHandler: completionHandler)
    }

    private func fetch(
        about name: String,
        under services: IndexingIterator<[AbstarctImageSearcher]>,
        completionHandler: @escaping (Bool) -> Void
    ) {
        var services = services
        guard let service = services.next() else {
            error = ImageSearchError.itemsIsNotExists
            completionHandler(false)
            return
        }

        service.fetch(about: name) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                let nsName = name as NSString
                self.cachedImages.setObject(response, forKey: nsName)
                completionHandler(true)
            case .failure:
                print(service, name, services)

                self.fetch(about: name, under: services.makeIterator(), completionHandler: completionHandler)
            }
        }
    }
}
