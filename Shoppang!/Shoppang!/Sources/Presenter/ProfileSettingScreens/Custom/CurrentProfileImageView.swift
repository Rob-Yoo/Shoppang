//
//  EditProfileImageView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import SnapKit
import Then

final class CurrentProfileImageView: UIView {

    lazy var profileImageView = ProfileImageView().then {
        $0.layer.borderWidth = 5
        $0.layer.borderColor = UIColor.mainTheme.cgColor
        $0.alpha = 1
    }
    
    private let cameraImageView = CameraImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure Subviews
extension CurrentProfileImageView {
    private func configureHierarchy() {
        self.addSubview(profileImageView)
        self.addSubview(cameraImageView)
    }
    
    private func configureLayout() {
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cameraImageView.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.height.equalTo(cameraImageView.snp.width)
        }
    }
}
