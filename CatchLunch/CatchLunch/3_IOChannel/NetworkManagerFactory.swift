//
//  NetworkManagerFactory.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/28.
//

import Foundation

struct NetworkManagerFactory {
    static func basic() -> some NetworkManagable {
        return NetworkManager(session: URLSession(configuration: .default))
    }
}
