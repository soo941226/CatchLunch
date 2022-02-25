//
//  Sessionable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

protocol Sessionable {
    associatedtype Requestable
    associatedtype Task: Taskable
    
    func dataTask(
        with request: Requestable,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> Task
}

extension URLSession: Sessionable {
    typealias Requestable = URLRequest
    typealias Task = URLSessionDataTask
}
