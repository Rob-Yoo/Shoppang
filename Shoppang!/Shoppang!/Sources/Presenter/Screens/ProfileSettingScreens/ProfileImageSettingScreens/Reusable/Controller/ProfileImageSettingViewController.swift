//
//  ProfileImageSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit

final class ProfileImageSettingViewController: BaseViewController<ProfileImageSettingView> {
    
    private var viewModel: ProfileImageViewModel
    
    init(contentView: ProfileImageSettingView, viewModel: ProfileImageViewModel) {
        self.viewModel = viewModel
        super.init(contentView: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addUserAction() {
        self.contentView.profileImageCollectionView.profileImageCollectionViewDelegate = self
    }
    
    override func binViewModel() {
        self.viewModel.outputProfileImageNumber.bind { [weak self] imageNumber in
            self?.updateProfileImageSettingView(imageNumber: imageNumber)
        }
    }
}

//MARK: - User Action Handling
extension ProfileImageSettingViewController: ProfileImageCollectionViewDelegate {
    func profileImageSelected(idx: Int) {
        self.viewModel.inputProfileImageNumber.value = idx
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

