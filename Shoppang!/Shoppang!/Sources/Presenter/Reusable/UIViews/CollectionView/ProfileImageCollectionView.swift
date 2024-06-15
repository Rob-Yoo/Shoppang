//
//  ProfileImageCollectionView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit

final class ProfileImageCollectionView: UICollectionView {
    private let profileImages = UIImage.profileImages
    
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
        return self.profileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profileImage = self.profileImages[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.reusableIdentifier, for: indexPath) as? ProfileImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(image: profileImage)
        return cell
    }
    
    
}
