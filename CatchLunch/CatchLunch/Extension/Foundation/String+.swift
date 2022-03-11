//
//  String+.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/07.
//

extension String {
    static let meesageAboutInterfaceBuilder = "Do not create any cell with InterfaceBuilder"

    func prepended<SomeString: StringProtocol>(_ string: SomeString?) -> String {
        guard let string = string else {
            return self
        }

        return string + self
    }
}
