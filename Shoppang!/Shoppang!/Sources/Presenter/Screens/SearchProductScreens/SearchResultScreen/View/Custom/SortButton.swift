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
            self.updateState()
        }
    }
    
    init(type: SortType, selectedBgColor: UIColor = .mainTheme, unselectedBgColor: UIColor = .white, isSelected: Bool = false) {
        self.selectedBgColor = selectedBgColor
        self.unselectedBgColor = unselectedBgColor
        self.type = type
        
        super.init(title: type.title)
        self.isSelected = isSelected
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.updateState()
        self.titleLabel?.font = .medium14
        self.layer.borderColor = UIColor.placeholder.cgColor
        self.layer.borderWidth = 0.7
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
    
    private func updateState() {
        let titleColor: UIColor = isSelected ? .white : .black
        
        self.backgroundColor = isSelected ? selectedBgColor : unselectedBgColor
        self.setTitleColor(titleColor, for: .normal)
    }
}
