//
//  NetworkManagable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

import Foundation

protocol NetworkManagable {
    associatedtype Session: Sessionable
    typealias Requestable = Session.Requestable

    var request: Requestable? { get }
    var session: Session { get }

    init(session: Session)
    func setUpRequest(with request: Requestable)
    func dataTask(completionHandler: @escaping (Result<Data, Error>) -> Void)
}
