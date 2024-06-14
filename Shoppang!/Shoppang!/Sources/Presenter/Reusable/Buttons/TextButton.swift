//
//  TextButton.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

class TextButton: UIButton {
    
    init(title: String, titleColor: UIColor = .white, font: UIFont = .medium13, bgColor: UIColor = .mainTheme) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = bgColor
    }
    
    convenience init(type: TextButtonType) {
        self.init(title: type.rawValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TextButton {
    enum TextButtonType: String {
        case start = "시작하기"
        case complete = "완료"
    }
}
