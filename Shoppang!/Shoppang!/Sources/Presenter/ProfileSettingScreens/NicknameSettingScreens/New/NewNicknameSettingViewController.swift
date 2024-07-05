//
//  NewNicknameSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import Combine

class NewNicknameSettingViewController: BaseViewController<NicknameSettingView> {
    
    private let model: ProfileModel
    private var cancellable = Set<AnyCancellable>()

    init(contentView: NicknameSettingView, model: ProfileModel) {
        self.model = model
        super.init(contentView: contentView)
    }
    
    override func addUserAction() {
        let profileImageViewTapGR = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        
        self.contentView.editableProfileImageView.addGestureRecognizer(profileImageViewTapGR)
        self.contentView.nicknameTextFieldView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange), for: .editingChanged)
        self.contentView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        self.addKeyboardDismissAction()
    }
    
    override func observeModel() {
        self.model.$nickname
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateNickNicknameTextFieldView()
            }
            .store(in: &cancellable)
        
        self.model.$profileImageNumber
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.updateEditableProfileImageView(imageNumber: new)
            }
            .store(in: &cancellable)
    }
}

//MARK: - User Action Handling
extension NewNicknameSettingViewController {
    @objc private func profileImageViewTapped() {
        let nextVC = ProfileImageSettingViewController(contentView: ProfileImageSettingView(type: .New), model: self.model)

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func nicknameTextFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        self.model.nickname = text
    }
    
    @objc private func completeButtonTapped() {
        self.model.saveProfile()

        if (self.model.checkNicknameValidationStatus() == .ok) {
            NavigationManager.changeWindowScene(didDeleteAccount: false)
        }
    }
}

//MARK: - Update Views
extension NewNicknameSettingViewController {
    private func updateNickNicknameTextFieldView() {
        let status = self.model.checkNicknameValidationStatus()
        let nicknameTextFieldView = self.contentView.nicknameTextFieldView

        nicknameTextFieldView.update(status: status)
    }
    
    private func updateEditableProfileImageView(imageNumber: Int) {
        let profileImage = UIImage.profileImages[imageNumber]
        let profileImageView = self.contentView.editableProfileImageView.profileImageView
        
        profileImageView.update(image: profileImage)
    }
}
