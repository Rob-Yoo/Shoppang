//
//  ProfileSettingView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import SnapKit
import Then

final class ProfileSettingView: UIView {
    let settingType: ProfileSettingType
    
    private let editableProfileImageView = EditableProfileImageView()
    private let nicknameTextFieldView = NicknameTextFieldView()
    private lazy var completeButton = TextButton(type: .complete)
    
    init(type: ProfileSettingType) {
        self.settingType = type
        super.init(frame: .zero)
        self.configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Configure Subviews
extension ProfileSettingView {
    private func configureSubviews() {
        self.configureEditableProfileImageView()
        self.configureNicknameTextFieldView()
        
        if (settingType == .Initial) {
            self.configureCompleteButton()
        }
    }
    
    private func configureEditableProfileImageView() {
        self.addSubview(editableProfileImageView)
        
        editableProfileImageView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.height.equalTo(editableProfileImageView.snp.width)
        }
    }
    
    private func configureNicknameTextFieldView() {
        self.addSubview(nicknameTextFieldView)
        
        nicknameTextFieldView.snp.makeConstraints {
            $0.top.equalTo(editableProfileImageView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
    }
    
    private func configureCompleteButton() {
        self.addSubview(completeButton)
        
        completeButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextFieldView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(nicknameTextFieldView)
            $0.height.equalTo(nicknameTextFieldView.snp.height).multipliedBy(0.5)
        }
    }
}
