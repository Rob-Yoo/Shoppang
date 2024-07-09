//
//  NewNicknameSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

class NewNicknameSettingViewController: BaseViewController<NicknameSettingView> {
    
    private let viewModel: ProfileViewModel
    
    init(contentView: NicknameSettingView, viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(contentView: contentView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.inputViewWillAppearTrigger.value = ()
    }
    
    override func addUserAction() {
        let profileImageViewTapGR = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))
        
        self.contentView.editableProfileImageView.addGestureRecognizer(profileImageViewTapGR)
        self.contentView.nicknameTextFieldView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange), for: .editingChanged)
        self.contentView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        self.addKeyboardDismissAction()
    }
    
    override func binViewModel() {
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
extension NewNicknameSettingViewController {
    @objc private func profileImageViewTapped() {
        let nextVC = ProfileImageSettingViewController(contentView: ProfileImageSettingView(type: .New), viewModel: self.viewModel.profileImageViewModel)

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
extension NewNicknameSettingViewController {
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
