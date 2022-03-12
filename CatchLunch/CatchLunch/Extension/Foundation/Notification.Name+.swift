//
//  Notification.Name+.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

import Foundation

extension Notification.Name {
    static let startTask = Notification.Name(rawValue: "startTask")
    static let finishTask = Notification.Name(rawValue: "finishTask")
    static let finishTaskWithError = Notification.Name(rawValue: "finishTaskWithError")
}
