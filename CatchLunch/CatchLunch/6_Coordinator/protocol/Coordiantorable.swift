//
//  Coordiantorable.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/02.
//
import UIKit

protocol Coordiantorable: AnyObject {
    var childCoordinators: [Coordiantorable] { get }

    init(on navigationController: UINavigationController)

    func start()
    func next()
}
