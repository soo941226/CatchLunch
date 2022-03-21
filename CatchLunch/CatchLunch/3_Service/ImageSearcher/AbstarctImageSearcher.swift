//
//  AbstarctImageSearcher.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/20.
//

import UIKit

class AbstarctImageSearcher: SingleItemSearchService {
    typealias Response = UIImage
    private(set) var manager: NetworkManagable
    private(set) var decoder = JSONDecoder()

    init(manager: NetworkManagable = NetworkManager()) {
        self.manager = manager
    }

    func fetch(about request: String, completionHandler: @escaping CompletionHandler) { }
}
