//
//  NetworkManagable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

protocol NetworkManagable {
    associatedtype Session: Sessionable
    typealias Request = Session.Request

    var request: Request? { get }
    var session: Session { get }

    init(session: Session)
    func setUpRequest(with request: Request)
    func dataTask(completionHandler: @escaping (Result<Data, Error>) -> Void)
}
