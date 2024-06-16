//
//  MultiStateTextButton.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

final class SortButton: TextButton {
    
    private let selectedBgColor: UIColor
    private let unselectedBgColor: UIColor
    let type: SortType

    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? selectedBgColor : unselectedBgColor
        }
    }
    
    init(title: String, type: SortType, selectedBgColor: UIColor = .charcoal, unselectedBgColor: UIColor = .white, isSelected: Bool = false) {
        self.selectedBgColor = selectedBgColor
        self.unselectedBgColor = unselectedBgColor
        self.type = type
        
        super.init(title: title)
        self.isSelected = isSelected
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.white, for: .selected)
        self.backgroundColor = self.unselectedBgColor
        self.layer.borderColor = UIColor.placeholder.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
}
