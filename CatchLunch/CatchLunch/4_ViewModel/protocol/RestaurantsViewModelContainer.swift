//
//  RestaurantsViewModelContainer.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import Foundation

protocol RestaurantsViewModelContainer: AnyObject {
    var selectedModel: RestaurantSummary? { get }
    func select()
    func requestNextItems()
}
