//
//  ProfileImageSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit

final class ProfileImageSettingViewController: BaseViewController<ProfileImageSettingView> {
    
    private var viewModel: ProfileImageViewModel
    
    var deliverProfileImageNumber: ((Int) -> Void)?
    
    init(contentView: ProfileImageSettingView, viewModel: ProfileImageViewModel) {
        self.viewModel = viewModel
        super.init(contentView: contentView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let profileImageNumber = self.viewModel.outputProfileImageNumber.value

        self.deliverProfileImageNumber?(profileImageNumber)
    }

    override func addUserAction() {
        self.contentView.profileImageCollectionView.profileImageCollectionViewDelegate = self
    }
    
    override func bindViewModel() {
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

