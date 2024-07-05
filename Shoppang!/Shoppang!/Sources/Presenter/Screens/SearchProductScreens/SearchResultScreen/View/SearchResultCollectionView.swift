//
//  SearchResultCollectionView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import SnapKit
import Then

final class SearchResultCollectionView: UICollectionView {

    init(layout: () -> UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout())
        self.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reusableIdentifier)
        self.showsVerticalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(isNew: Bool) {
        self.reloadData()
        if (isNew) { self.scrollUpToTop() }
    }
    
    private func scrollUpToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.scrollToItem(at: indexPath, at: .top, animated: false)
    }
}
