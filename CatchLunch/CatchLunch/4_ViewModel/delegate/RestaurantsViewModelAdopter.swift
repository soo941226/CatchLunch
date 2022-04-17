//
//  RestaurantsViewModelAdopter.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import UIKit

protocol RestaurantsViewModelAdopter: AnyObject {
    var selectedModel: RestaurantSummary? { get }
    func retrieve(image completionHandler: @escaping (UIImage?) -> Void)
    func select()
    func requestNextItems()
}
