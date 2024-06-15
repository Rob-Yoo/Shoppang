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
}

//MARK: - User Action Handling
extension NewNicknameSettingViewController {
    @objc private func profileImageViewTapped() {
        let nextVC = ProfileImageSettingViewController<NewProfileImageSettingView>()

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func nicknameTextFieldDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        self.model.nickname = text
    }
}

//MARK: - Observing Model
extension NewNicknameSettingViewController {
    private func observingModel() {
        self.model.$nickname
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                let status = self?.model.nicknameValidationStatus ?? .countError

                self?.contentView.nicknameSettingView.nicknameTextFieldView.update(status: status)
            }
            .store(in: &cancellable)
        
//        self.model.$profileImage
//            .sink { [weak self] new in
////                print(new)
//            }
//            .store(in: &cancellable)
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
