//
//  EditNicknameSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit
import Combine

final class EditNicknameSettingViewController: BaseViewController<NicknameSettingView> {
    
    private let model: EditProfileModel
    private var cancellable = Set<AnyCancellable>()
    
    init(contentView: NicknameSettingView, model: EditProfileModel) {
        self.model = model
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
    
    override func observeModel() {
        self.model.$nickname
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateNickNicknameTextFieldView()
            }
            .store(in: &cancellable)
        
        self.model.$profileImageNumber
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateEditableProfileImageView()
            }
            .store(in: &cancellable)
    }
    
}

//MARK: - User Action Handling
extension EditNicknameSettingViewController {
    
    @objc private func saveButtonTapped() {
        self.model.saveProfile()
        if (self.model.checkNicknameValidationStatus() == .ok) {
            self.navigationController?.popViewController(animated: true)            
        }
    }
    
    @objc private func profileImageViewTapped() {
        let nextVC = ProfileImageSettingViewController(contentView: ProfileImageSettingView(type: .Editing), model: self.model)

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func nicknameTextFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        self.model.nickname = text
    }
}

//MARK: - Update Views
extension EditNicknameSettingViewController {
    private func updateNickNicknameTextFieldView() {
        let status = self.model.checkNicknameValidationStatus()
        let nicknameTextFieldView = self.contentView.nicknameTextFieldView

        nicknameTextFieldView.nicknameTextField.text = self.model.nickname
        nicknameTextFieldView.update(status: status)
    }
    
    private func updateEditableProfileImageView() {
        let profileImage = UIImage.profileImages[self.model.profileImageNumber]
        let profileImageView = self.contentView.editableProfileImageView.profileImageView
        
        profileImageView.update(image: profileImage)
    }
}
