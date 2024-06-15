//
//  ProfileImageSettingView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit
import SnapKit

final class ProfileImageSettingView: UIView {
    
    private let currentProfileImageView = CurrentProfileImageView()
    
    private let profileImageCollectionView = ProfileImageCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 50) / 4
        let height = width

        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        return layout
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
extension ProfileImageSettingView {
    private func configureHierarchy() {
        self.addSubview(currentProfileImageView)
        self.addSubview(profileImageCollectionView)
    }
    
    private func configureLayout() {
        currentProfileImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.height.equalTo(currentProfileImageView.snp.width)
        }
        
        profileImageCollectionView.snp.makeConstraints {
            $0.top.equalTo(currentProfileImageView.snp.bottom).offset(50)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
    }
}
