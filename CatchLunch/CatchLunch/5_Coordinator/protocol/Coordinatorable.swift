//
//  Coordinatorable.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/02.
//
import UIKit

protocol ParentCoordinator: AnyObject {
    var model: RestaurantSummary? { get }
    func retrieve(image completionHandler: @escaping (UIImage?) -> Void)
}

protocol Coordinatorable: AnyObject {
    init(on navigationController: UINavigationController)
    var children: [Coordinatorable] { get }
    func start()
}
