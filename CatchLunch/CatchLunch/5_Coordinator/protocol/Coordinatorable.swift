//
//  Coordinatorable.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/02.
//
import UIKit

protocol ParentCoordinator: AnyObject {
    var model: RestaurantInformation? { get }
}

protocol Coordinatorable: AnyObject {
    init(on navigationController: UINavigationController)
    var childCoodinator: [Coordinatorable] { get }
    func start()
}
