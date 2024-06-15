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
    }
    
    private let cameraImageView = UIImageView().then {
        $0.image = UIImage(systemName: "camera.fill")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
        $0.backgroundColor = .mainTheme
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        // TODO: - 제대로 동작 안되므로 나중에 카메라 이미지뷰는 동글게 처리해야함
        self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.width / 2
        self.cameraImageView.clipsToBounds = true
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
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
    }
}
