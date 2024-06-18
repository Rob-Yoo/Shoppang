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
    
    var productList = [Product]() {
        didSet {
            self.reloadData()
            
            guard !productList.isEmpty, oldValue.count >= productList.count else { return }

            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToItem(at: indexPath, at: .top, animated: true)
        }
    }
    var cartList = SearchResultModel.loadCartList() {
        didSet {
            self.reloadData()
        }
    }
    
    init(layout: () -> UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout())
        self.delegate = self
        self.dataSource = self
        self.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.reusableIdentifier)
        self.showsVerticalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = self.productList[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.reusableIdentifier, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCellData(data: product, isCart: cartList.contains(product.productId))
        return cell
    }
}
