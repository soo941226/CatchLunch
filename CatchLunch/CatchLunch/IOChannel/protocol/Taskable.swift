//
//  Taskable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

protocol Taskable {
    func cancel()
    func resume()
    func suspend()
}

extension URLSessionDataTask: Taskable { }
