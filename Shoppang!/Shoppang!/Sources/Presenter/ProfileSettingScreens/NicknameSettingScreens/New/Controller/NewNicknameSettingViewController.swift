//
//  NewNicknameSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import Combine

class NewNicknameSettingViewController: BaseViewController<NewNicknameSettingView> {
    
    private let model = ProfileModel()
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.observingModel()
        self.addUserAction()
    }

    private func addUserAction() {
        self.addActionToProfileImageView()
        self.addActionToNicknameTextField()
    }
    
    private func addActionToProfileImageView() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))

        self.contentView.nicknameSettingView.editableProfileImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func addActionToNicknameTextField() {
        self.contentView.nicknameSettingView.nicknameTextFieldView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange), for: .editingChanged)
    }
    
    private func addActionToCompleteButton() {
        self.contentView.nicknameSettingView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
}

//MARK: - User Action Handling
extension NewNicknameSettingViewController {
    @objc private func profileImageViewTapped() {
        let nextVC = ProfileImageSettingViewController<NewProfileImageSettingView>(model: self.model)

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func nicknameTextFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        self.model.nickname = text
    }
    
    @objc private func completeButtonTapped() {
        self.model.saveProfile()
        
        //TODO: - 메인 화면으로 넘어가기
    }
}

//MARK: - Observing Model
extension NewNicknameSettingViewController {
    private func observingModel() {
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

//MARK: - Update Views
extension NewNicknameSettingViewController {
    private func updateNickNicknameTextFieldView() {
        let status = self.model.nicknameValidationStatus
        let nicknameTextFieldView = self.contentView.nicknameSettingView.nicknameTextFieldView

        nicknameTextFieldView.update(status: status)
    }
    
    private func updateEditableProfileImageView(imageNumber: Int) {
        let profileImage = UIImage.profileImages[imageNumber]
        let profileImageView = self.contentView.nicknameSettingView.editableProfileImageView.profileImageView
        
        profileImageView.update(image: profileImage)
    }
}

#if DEBUG
import SwiftUI
struct ViewControllerRepresentable_KMVC: UIViewControllerRepresentable {
    
func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController{
    NewNicknameSettingViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_KMVC_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable_KMVC()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
        }
        
    }
} #endif
