//
//  ProfileSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

class NewProfileSettingViewController: BaseViewController<NewProfileSettingView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addUserAction()
    }

    private func addUserAction() {
        self.addActionToProfileImageView()
    }
    
    private func addActionToProfileImageView() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageViewTapped))

        self.contentView.profileSettingView.editableProfileImageView.addGestureRecognizer(gestureRecognizer)
    }
}

//MARK: - User Action Handling
extension NewProfileSettingViewController {
    @objc private func profileImageViewTapped() {
        let nextVC = ProfileImageSettingViewController<NewProfileImageSettingView>()

        self.navigationController?.pushViewController(nextVC, animated: true)
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
    NewProfileSettingViewController()
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
