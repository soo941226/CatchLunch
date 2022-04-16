//
//  SearchServiceable.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/23.
//

protocol SearchServiceable {
    associatedtype Response
    typealias CompletionHandler = (Result<Response, Error>) -> Void
}

protocol SingleItemSearchService: SearchServiceable {
    associatedtype Request
    func fetch(about request: Request, completionHandler: @escaping CompletionHandler)
}

protocol PagingSearchService: SearchServiceable {
    func fetch(
        pageIndex: Int,
        requestItemAmount: Int,
        completionHandler: @escaping CompletionHandler
    )
}
