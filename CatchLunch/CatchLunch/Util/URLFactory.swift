//
//  URLFactory.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/20.
//

import Foundation

enum URLFactory {
    private static let unwantedPrefixes = [
        "https://search.pstatic.net/sunny/?src="
    ]

    static func make(
        from link: String
    ) -> URL? {
        guard link.firstIndex(of: "*") != nil else {
            return URL(string: link)
        }

        for unwantedPrefix in unwantedPrefixes {
            guard let range = link.range(of: unwantedPrefix) else {
                return URL(string: link)
            }

            var link = link
            link.removeSubrange(range)
            return URL(string: link)
        }

        return nil
    }
}
