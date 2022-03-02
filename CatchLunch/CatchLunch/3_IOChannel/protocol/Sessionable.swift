//
//  Sessionable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

protocol Sessionable {
    associatedtype Task: Taskable
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> Task
}

extension URLSession: Sessionable {
    typealias Task = URLSessionDataTask
}
