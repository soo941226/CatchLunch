//
//  SearchServiceable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

import Foundation

protocol SearchServiceable {
    associatedtype Response
    typealias CompletionHandler = (Result<Response, Error>) -> Void
}

protocol SingleItemSearchService: SearchServiceable {
    func fetch(about name: String, completionHandler: @escaping CompletionHandler)
}

protocol PagingSearchService: SearchServiceable {
    func fetch(
        itemPageIndex: Int,
        requestItemAmount: Int,
        completionHandler: @escaping CompletionHandler
    )
}
