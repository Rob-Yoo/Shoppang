//
//  EditNicknameSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit
import Combine

final class EditNicknameSettingViewController: BaseViewController<EditNicknameSettingView> {
    
    private let model: EditProfileModel
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        self.model = EditProfileModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addUserAction()
        self.observeModel()
    }
    
    private func addUserAction() {
        self.addActionToSaveButton()
        self.addActionToProfileImageView()
        self.addActionToNicknameTextField()
        self.addKeyboardDismissAction()
    }
    
    private func addActionToSaveButton() {
        let saveButton = UIBarButtonItem(title: Literal.ButtonTitle.Save, style: .plain, target: self, action: #selector(saveButtonTapped))
        
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    private func addActionToProfileImageView() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))

        self.contentView.nicknameSettingView.editableProfileImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func addActionToNicknameTextField() {
        self.contentView.nicknameSettingView.nicknameTextFieldView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange), for: .editingChanged)
    }
    
    private func addKeyboardDismissAction() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.contentView.addGestureRecognizer(gestureRecognizer)
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
        let nextVC = ProfileImageSettingViewController<EditProfileImageSettingView, EditProfileModel>(model: self.model)

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func nicknameTextFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        self.model.nickname = text
    }

    @objc private func dismissKeyboard() {
        self.contentView.endEditing(true)
    }
}

//MARK: - Observing Model
extension EditNicknameSettingViewController {
    private func observeModel() {
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

//MARK: - Update Views
extension EditNicknameSettingViewController {
    private func updateNickNicknameTextFieldView() {
        let status = self.model.checkNicknameValidationStatus()
        let nicknameTextFieldView = self.contentView.nicknameSettingView.nicknameTextFieldView

        nicknameTextFieldView.nicknameTextField.text = self.model.nickname
        nicknameTextFieldView.update(status: status)
    }
    
    private func updateEditableProfileImageView() {
        let profileImage = UIImage.profileImages[self.model.profileImageNumber]
        let profileImageView = self.contentView.nicknameSettingView.editableProfileImageView.profileImageView
        
        profileImageView.update(image: profileImage)
    }
}
