//
//  EditNicknameSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit

final class EditNicknameSettingViewController: BaseViewController<NicknameSettingView> {
    
    private let viewModel: ProfileViewModel
    
    init(contentView: NicknameSettingView, viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(contentView: contentView)
    }
    
    override func addUserAction() {
        let saveButton = UIBarButtonItem(title: Literal.ButtonTitle.Save, style: .plain, target: self, action: #selector(saveButtonTapped))
        let profileImageViewTapGR = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))

        
        self.navigationItem.rightBarButtonItem = saveButton
        self.contentView.editableProfileImageView.addGestureRecognizer(profileImageViewTapGR)
        self.contentView.nicknameTextFieldView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange), for: .editingChanged)
        self.addKeyboardDismissAction()
    }
    
    override func bindViewModel() {
        self.viewModel.outputNicknameValidationStatus.bind { [weak self] status in
            self?.updateNickNicknameTextFieldView(status: status)
        }
        
        self.viewModel.outputProfileImageNumber.bind { [weak self] imageNumber in
            self?.updateEditableProfileImageView(imageNumber: imageNumber)
        }
        
        self.viewModel.outputValidation.bind { [weak self] validation in
            if (validation) {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

//MARK: - User Action Handling
extension EditNicknameSettingViewController {
    
    @objc private func saveButtonTapped() {
        self.viewModel.inputSaveButtonTapped.value = ()
    }
    
    @objc private func profileImageViewTapped() {
        let profileImageNumber = self.viewModel.outputProfileImageNumber.value
        let nextVC = ProfileImageSettingViewController(contentView: ProfileImageSettingView(type: .Editing), viewModel: ProfileImageViewModel(imageNumber: profileImageNumber))

        nextVC.deliverProfileImageNumber = { [weak self] number in
            self?.viewModel.inputProfileImageNumber.value = number
        }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func nicknameTextFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        self.viewModel.inputNickname.value = text
    }
}

//MARK: - Update Views
extension EditNicknameSettingViewController {
    private func updateNickNicknameTextFieldView(status: NicknameValidationStatus) {
        let nicknameTextFieldView = self.contentView.nicknameTextFieldView
        
        nicknameTextFieldView.nicknameTextField.text = self.viewModel.inputNickname.value
        nicknameTextFieldView.update(status: status)
    }
    
    private func updateEditableProfileImageView(imageNumber: Int) {
        let profileImage = UIImage.profileImages[imageNumber]
        let profileImageView = self.contentView.editableProfileImageView.profileImageView
        
        profileImageView.update(image: profileImage)
    }
}
