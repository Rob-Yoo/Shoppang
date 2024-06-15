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
    var profileImage: UIImage
    
    init(profileImage: UIImage) {
        self.profileImage = profileImage
        super.init(frame: .infinite)
        self.configure()
    }
    
    convenience init() {
        guard let image = UserDefaults.standard.object(forKey: "UserProfileImage") as? UIImage else {
            let randomImage = UIImage.profileImages.randomElement()!
    
            self.init(profileImage: randomImage)
            return
        }
        
        self.init(profileImage: image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    private func configure() {
        self.image = self.profileImage
        self.contentMode = .scaleAspectFill
        self.layer.borderColor = UIColor.mainTheme.cgColor
        self.layer.borderWidth = 3
    }
}
