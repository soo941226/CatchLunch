//
//  AsyncAfter.swift
//  CatchLunchTests
//
//  Created by kjs on 2022/03/02.
//

import Foundation

func asyncAfter(_ then: @escaping () -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 0.7) {
        then()
    }
}
