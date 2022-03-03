//
//  Sessionable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

protocol Sessionable {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: Sessionable { }
