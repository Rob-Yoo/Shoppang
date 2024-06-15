//
//  ProfileImageView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import SnapKit
import Then

final class ProfileImageView: UIView {
    var profileImage: UIImage
    
    private lazy var profileImageView = UIImageView().then {
        $0.image = self.profileImage
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = self.frame.width / 2
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.mainTheme.cgColor
        $0.layer.borderWidth = 3
    }
    
    init(profileImage: UIImage) {
        self.profileImage = profileImage
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
