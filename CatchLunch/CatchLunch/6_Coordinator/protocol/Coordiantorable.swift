//
//  Coordiantorable.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/02.
//
import UIKit

protocol Coordiantorable: AnyObject {
    init(on navigationController: UINavigationController)
    var childCoodinator: [Coordiantorable] { get }
    func start()
}
