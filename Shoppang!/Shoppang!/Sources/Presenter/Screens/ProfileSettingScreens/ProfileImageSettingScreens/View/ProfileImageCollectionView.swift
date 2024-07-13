//
//  ProfileImageCollectionView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit

protocol ProfileImageCollectionViewDelegate: AnyObject {
    func profileImageSelected(idx: Int)
}

final class ProfileImageCollectionView: UICollectionView {

    var selectedProfileImageNumber = 0 {
        didSet {
            self.reloadData()
        }
    }

    weak var profileImageCollectionViewDelegate: ProfileImageCollectionViewDelegate?
    
    init(layout: () -> UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout())
        self.delegate = self
        self.dataSource = self
        self.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.reusableIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileImageCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UIImage.profileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profileImage = UIImage.profileImages[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.reusableIdentifier, for: indexPath) as? ProfileImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(image: profileImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard (indexPath.item == selectedProfileImageNumber), let c = cell as? ProfileImageCollectionViewCell else { return }

        c.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let idx = indexPath.item
        
        guard let delegate = self.profileImageCollectionViewDelegate else {
            print("ProfileImageCollectionViewDelegate 설정 필요")
            return
        }
        
        delegate.profileImageSelected(idx: idx)
    }
}
