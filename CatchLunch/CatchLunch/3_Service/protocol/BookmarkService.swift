//
//  BookmarkService.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

protocol BookmarkService: SearchServiceable {
    func fetch(
        whereBookmarkedIs flag: Bool,
        completionHandler: @escaping (Result<[Response], Error>) -> Void
    )
    func toggleBookmark(about: Response, completionHandler: @escaping (Error?) -> Void)
    func checkBookmark(about: Response, completionHandler: @escaping (Bool) -> Void)
}
