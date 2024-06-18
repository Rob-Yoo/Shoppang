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
        self.uncolorProfileImageView()
    }
    
    func update(image: UIImage) {
        self.image = image
    }
    
    func update(isSelected: Bool) {
        isSelected ? self.colorProfileImageView() : self.uncolorProfileImageView()
    }
    
    func colorProfileImageView() {
        self.layer.borderColor = UIColor.mainTheme.cgColor
        self.layer.borderWidth = 3
        self.alpha = 1
    }
    
    func uncolorProfileImageView() {
        self.layer.borderColor = UIColor.placeholder.cgColor
        self.layer.borderWidth = 1
        self.alpha = 0.5
    }
}
