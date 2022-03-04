//
//  NetworkManagable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

protocol NetworkManagable {
    func setUpRequest(with request: URLRequest)
    func dataTask(completionHandler: @escaping (Result<Data, Error>) -> Void)
}
