//
//  ProfileImageView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import SnapKit
import Then

final class ProfileImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    private func configure() {
        self.contentMode = .scaleAspectFill
        self.layer.borderColor = UIColor.placeholder.cgColor
        self.layer.borderWidth = 1
        self.alpha = 0.5
    }
    
    func update(image: UIImage) {
        self.image = image
    }
    
    func update(isSelected: Bool) {
        self.layer.borderColor = (isSelected) ? UIColor.mainTheme.cgColor : UIColor.placeholder.cgColor
        self.layer.borderWidth = (isSelected) ? 3 : 1
        self.alpha = (isSelected) ? 1 : 0.5
    }
}
