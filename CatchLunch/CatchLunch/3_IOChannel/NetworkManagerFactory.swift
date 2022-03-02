//
//  NetworkManagerFactory.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/28.
//

import Foundation

final class NetworkManagerFactory {
    static func basic() -> NetworkManager<URLSession> {
        return NetworkManager(session: URLSession(configuration: .default))
    }
}
