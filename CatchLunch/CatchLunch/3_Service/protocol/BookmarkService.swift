//
//  BookmarkService.swift
//  CatchLunch
//
//  Created by kjs on 2022/02/25.
//

protocol BookmarkService {
    associatedtype Element

    func toggleBookmark(about: Element, completionHandler: @escaping (Error?) -> Void)
    func checkBookmark(about: Element, completionHandler: @escaping (Bool) -> Void)
}
