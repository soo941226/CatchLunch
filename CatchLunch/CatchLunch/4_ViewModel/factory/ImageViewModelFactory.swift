//
//  ImageViewModelFactory.swift
//  CatchLunch
//
//  Created by kjs on 2022/04/17.
//

struct ImageViewModelFactory {
    static func makeDefault() -> ImageViewModel {
        return ImageViewModel(service: NaverImageSearcher(), DaumImageSearcher())
    }
}
