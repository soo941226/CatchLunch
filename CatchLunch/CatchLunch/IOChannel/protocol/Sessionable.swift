//
//  Sessionable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

protocol Sessionable {
    associatedtype Request
    associatedtype Task: Taskable
    
    func dataTask(
        with request: Request,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> Task
}

extension URLSession: Sessionable {
    typealias Request = URLRequest
    typealias Task = URLSessionDataTask
}
