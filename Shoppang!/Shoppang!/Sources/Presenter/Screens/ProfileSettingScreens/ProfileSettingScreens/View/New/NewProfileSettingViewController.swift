//
//  NewProfileSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

class NewProfileSettingViewController: BaseViewController<ProfileSettingView> {
    
    private let viewModel: ProfileSettingViewModel
    
    init(contentView: ProfileSettingView, viewModel: ProfileSettingViewModel) {
        self.viewModel = viewModel
        super.init(contentView: contentView)
    }
    
    override func addUserAction() {
        let profileImageViewTapGR = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        
        self.contentView.editableProfileImageView.addGestureRecognizer(profileImageViewTapGR)
        self.contentView.nicknameTextFieldView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange), for: .editingChanged)
        self.contentView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        self.addKeyboardDismissAction()
    }
    
    override func bindViewModel() {
        self.viewModel.outputNicknameValidationStatus.bind { [weak self] status in
            self?.updateNicknameTextFieldView(status: status)
            self?.updateCompleteButton(status: status)
        }
        
        self.viewModel.outputProfileImageNumber.bind { [weak self] imageNumber in
            self?.updateEditableProfileImageView(imageNumber: imageNumber)
        }
        
        self.viewModel.outputValidation.bind { validation in
            if (validation) {
                NavigationManager.changeWindowScene(didDeleteAccount: false)
            }
        }
    }
}

//MARK: - User Action Handling
extension NewProfileSettingViewController {
    @objc private func profileImageViewTapped() {
        let profileImageNumber = self.viewModel.outputProfileImageNumber.value
        let nextVC = ProfileImageSettingViewController(contentView: ProfileImageSettingView(type: .New), viewModel: ProfileImageSettingViewModel(imageNumber: profileImageNumber))

        nextVC.deliverProfileImageNumber = { [weak self] number in
            self?.viewModel.inputProfileImageNumber.value = number
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func nicknameTextFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        self.viewModel.inputNickname.value = text
    }
    
    @objc private func completeButtonTapped() {
        self.viewModel.inputSaveButtonTapped.value = ()
    }
}

//MARK: - Update Views
extension NewProfileSettingViewController {
    private func updateNicknameTextFieldView(status: NicknameValidationStatus) {
        let nicknameTextFieldView = self.contentView.nicknameTextFieldView

        nicknameTextFieldView.update(status: status)
    }
    
    private func updateCompleteButton(status: NicknameValidationStatus) {
        if (status == .ok) {
            self.contentView.completeButton.backgroundColor = .mainTheme
            self.contentView.completeButton.isEnabled = true
        } else {
            self.contentView.completeButton.backgroundColor = .lightGray
            self.contentView.completeButton.isEnabled = false
        }
    }
    
    private func updateEditableProfileImageView(imageNumber: Int) {
        let profileImage = UIImage.profileImages[imageNumber]
        let profileImageView = self.contentView.editableProfileImageView.profileImageView
        
        profileImageView.update(image: profileImage)
    }
}
