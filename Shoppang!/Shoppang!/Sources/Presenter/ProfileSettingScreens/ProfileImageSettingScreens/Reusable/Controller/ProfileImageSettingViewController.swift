//
//  ProfileImageSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit
import Combine

final class ProfileImageSettingViewController<ContentView: ProfileImageSettingView>: BaseViewController<ContentView> {
    
    private let model: ProfileModel
    private var cancellable = Set<AnyCancellable>()
    
    init(model: ProfileModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.addUserAction()
        self.observingModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func addUserAction() {
        self.contentView.profileImageCollectionView.profileImageCollectionViewDelegate = self
    }
}

//MARK: - User Action Handling
extension ProfileImageSettingViewController: ProfileImageCollectionViewDelegate {
    func profileImageSelected(idx: Int) {
        self.model.profileImageNumber = idx
    }
}

//MARK: - Observing Model
extension ProfileImageSettingViewController {
    private func observingModel() {
        self.model.$profileImageNumber
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.updateProfileImageSettingView(imageNumber: new)
            }
            .store(in: &cancellable)
    }
}

//MARK: - Update Views
extension ProfileImageSettingViewController {
    private func updateProfileImageSettingView(imageNumber: Int) {
        let profileImage = UIImage.profileImages[imageNumber]
        let profileImageView =  self.contentView.currentProfileImageView.profileImageView
        let profileImageCollectionView = self.contentView.profileImageCollectionView
        
        profileImageView.update(image: profileImage)
        profileImageCollectionView.selectedProfileImageNumber = imageNumber
    }
}

#if DEBUG
import SwiftUI
struct ViewControllerRepresentable_PISVC: UIViewControllerRepresentable {
    
func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController{
    ProfileImageSettingViewController<NewProfileImageSettingView>(model: ProfileModel())
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PISVC_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable_PISVC()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
        }
        
    }
} #endif
