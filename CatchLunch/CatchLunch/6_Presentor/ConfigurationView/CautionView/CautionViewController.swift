//
//  CautionViewController.swift
//  CatchLunch
//
//  Created by kjs on 2022/03/22.
//

import UIKit

final class CautionViewController: UIViewController {
    private let textView = UITextView()
    override func loadView() {
        view = textView
        textView.directionalLayoutMargins = .init(dx: .headInset, dy: .headInset)
        textView.font = .preferredFont(forTextStyle: .body)
        textView.text = """
유의사항: CatchLunch 내에서 가져오는 모든 이미지는 네이버 및 다음을 통해 음식이름을 검색하여 가져온 이미지입니다.
따라서 해당 음식 및 음식점과 관련이 없을 수 있습니다.
"""
    }
}
