//
//  ImageSearchService.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

import UIKit

protocol ImageSearchService {
    func fetchImage(
        about name: String,
        then: @escaping (Result<[UIImage], Error>) -> Void
    )
}
