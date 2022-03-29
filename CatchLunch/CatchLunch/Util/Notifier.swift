//
//  Notifier.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/29.
//

import Foundation

protocol Notifier {
    func postStartTask()
    func postFinishTask()
    func postFinishTaskWithError(message: String)
}

extension Notifier {
    func postStartTask() {
        NotificationCenter.default.post(name: .startTask, object: nil)
    }

    func postFinishTask() {
        NotificationCenter.default.post(name: .finishTask, object: nil)
    }

    func postFinishTaskWithError(message: String = "더이상 요청할 수 없습니다") {
        NotificationCenter.default.post(name: .finishTaskWithError, object: nil, userInfo: [
            "message": message
        ])
    }
}
