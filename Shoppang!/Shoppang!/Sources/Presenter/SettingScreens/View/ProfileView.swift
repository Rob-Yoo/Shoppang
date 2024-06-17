//
//  ProfileView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit
import SnapKit
import Then

final class ProfileView: UIView {
    
    private let profileImageView = ProfileImageView().then {
        $0.image = UIImage.profileImages[0]
        $0.colorProfileImageView()
    }
    
    private let nicknameLabel = UILabel().then {
        $0.text = "지뉴지뉴"
        $0.textColor = .black
        $0.font = .bold16
        $0.numberOfLines = 1
    }
    
    private let joinDateLabel = UILabel().then {
        $0.text = "2024.06.17 가입"
        $0.textColor = .placeholder
        $0.font = .regular13
    }
    
    private let rightArrowImageView = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.contentMode = .scaleAspectFill
        $0.tintColor = .lightGray
    }
    
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
extension ProfileView {
    private func configureHierarchy() {
        self.addSubview(profileImageView)
        self.addSubview(nicknameLabel)
        self.addSubview(joinDateLabel)
        self.addSubview(rightArrowImageView)
    }
    
    private func configureLayout() {
        profileImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(30)
            $0.leading.equalToSuperview()
            $0.width.equalTo(profileImageView.snp.height)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        joinDateLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(3)
            $0.leading .equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        rightArrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(profileImageView.snp.size).multipliedBy(0.2)
        }
    }
}
