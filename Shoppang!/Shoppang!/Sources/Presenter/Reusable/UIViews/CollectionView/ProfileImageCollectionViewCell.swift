//
//  ProfileImageCollectionViewCell.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit
import SnapKit

final class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    private let profileImageView = ProfileImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureProfileImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureProfileImageView() {
        self.contentView.addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureCellData(image: UIImage) {
        self.profileImageView.profileImage = image
    }
}
