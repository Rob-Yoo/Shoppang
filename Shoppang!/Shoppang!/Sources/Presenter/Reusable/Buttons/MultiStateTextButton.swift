//
//  MultiStateTextButton.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

class MultiStateTextButton: TextButton {
    
    private let selectedBgColor: UIColor
    private let unselectedBgColor: UIColor
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? selectedBgColor : unselectedBgColor
        }
    }
    
    init(title: String, selectedBgColor: UIColor = .charcoal, unselectedBgColor: UIColor = .white, isSelected: Bool = false) {
        self.selectedBgColor = selectedBgColor
        self.unselectedBgColor = unselectedBgColor
        
        super.init(title: title)
        
        self.isSelected = isSelected
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.white, for: .selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
