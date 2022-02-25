//
//  ImageSearchService.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

import UIKit

protocol ImageSearchService {
    associatedtype NetworkManager: NetworkManagable

    var manager: NetworkManager { get }
    init(manager: NetworkManager )

    func setUpRequest(request: NetworkManager.Requestable)
    func fetchImage(
        about name: String,
        completionHandler: @escaping (Result<UIImage, Error>) -> Void
    )
}
