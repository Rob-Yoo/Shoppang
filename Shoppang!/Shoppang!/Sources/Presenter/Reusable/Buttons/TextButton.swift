//
//  TextButton.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

class TextButton: UIButton {
    
    init(title: String, titleColor: UIColor = .white, font: UIFont = .bold15, bgColor: UIColor = .mainTheme) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    convenience init(type: TextButtonType) {
        self.init(title: type.title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TextButton {
    enum TextButtonType {
        case start
        case complete
        
        var title: String {
            switch self {
            case .start:
                return Literal.ButtonTitle.Start
            case .complete:
                return Literal.ButtonTitle.Complete
            }
        }
    }
}
