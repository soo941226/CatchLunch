//
//  NetworkManagable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

class NetworkManagable<Requstable> {
    private(set) var request: Requstable?

    func setUpRequest(with request: Requstable) {
        self.request = request
    }

    func dataTask(
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) { }
}
