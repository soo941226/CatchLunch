//
//  NetworkManagable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

protocol NetworkManagable {
    func dataTask(
        completionHandler: @escaping (Result<Data, Error>) -> Void
    )
}
