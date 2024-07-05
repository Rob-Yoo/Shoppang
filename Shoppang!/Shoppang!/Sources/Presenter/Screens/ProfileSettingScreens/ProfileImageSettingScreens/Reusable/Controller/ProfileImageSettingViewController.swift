//
//  ProfileImageSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit
import Combine

final class ProfileImageSettingViewController: BaseViewController<ProfileImageSettingView> {
    
    private var model: ProfileImageProtocol
    private var cancellable = Set<AnyCancellable>()
    
    init(contentView: ProfileImageSettingView, model: ProfileImageProtocol) {
        self.model = model
        super.init(contentView: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func addUserAction() {
        self.contentView.profileImageCollectionView.profileImageCollectionViewDelegate = self
    }
    
    override func observeModel() {
        self.model.profileImageNumberPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.updateProfileImageSettingView(imageNumber: new)
            }
            .store(in: &cancellable)
    }
}

//MARK: - User Action Handling
extension ProfileImageSettingViewController: ProfileImageCollectionViewDelegate {
    func profileImageSelected(idx: Int) {
        self.model.setProfileImageNumber(number: idx)
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

