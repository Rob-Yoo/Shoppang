//
//  AppleProductCollectionView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit

final class AppleProductCollectionView: UICollectionView {
    
    init() {
        super.init(frame: .zero, collectionViewLayout: AppleProductCollectionView.layout())
        self.backgroundColor = .mainTheme
        
        self.register(AppleProductCollectionViewCell.self, forCellWithReuseIdentifier: AppleProductCollectionViewCell.reusableIdentifier)
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        return layout
    }
    
//    override func layoutIfNeeded() {
//        super.layoutIfNeeded()
//        
//        guard let layout = self.collectionViewLayout as? UICollectionViewFlowLayout else {
//            return
//        }
//        
//        let width = (self.frame.width - 3) / 2.5
//        let height = self.frame.height - 2
//        layout.itemSize = CGSize(width: width, height: height)
//        layout.minimumLineSpacing = 1
//    }
//    
    override func draw(_ rect: CGRect) {
        print(#function)
        guard let layout = self.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        let width = (self.frame.width - 3) / 2.5
        let height = self.frame.height - 2
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 1
    }
//    override func updateConstraintsIfNeeded() {
//        guard let layout = self.collectionViewLayout as? UICollectionViewFlowLayout else {
//            return
//        }
//
//        let width = (self.frame.width - 3) / 2.5
//        let height = self.frame.height - 2
//        layout.itemSize = CGSize(width: width, height: height)
//        layout.minimumLineSpacing = 1
//    }
}
