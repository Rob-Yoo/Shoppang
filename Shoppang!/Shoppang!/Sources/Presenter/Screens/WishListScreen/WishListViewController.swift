//
//  WishListViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import UIKit
import Combine

final class WishListViewController: BaseViewController<WishListRootView> {
    
    private let model: WishListModel
    private var cancellable = Set<AnyCancellable>()
    
    init(model: WishListModel) {
        self.model = model
        super.init()
    }
    
    override func addUserAction() {
        self.contentView.productCollectionView.delegate = self
        self.contentView.productCollectionView.dataSource = self
    }
    
    override func observeModel() {
        self.model.$wishList
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.contentView.productCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}

//MARK: - CollectionView Delegate/DataSource
extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.wishList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = self.model.wishList[indexPath.item]
        let isWishList = self.model.isWishList(productID: product.productId)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reusableIdentifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(data: product, isWishList: isWishList)
        return cell
    }

}

//MARK: - User Action Handling
extension WishListViewController: ProductCollectionViewCellDelegate {
    func wishButtonTapped(idx: Int) {
        let product = self.model.wishList[idx]
        let isWishList = self.model.isWishList(productID: product.productId)

        if (isWishList) {
            self.model.removeFromWishList(productID: product.productId)
        } else {
            self.model.addToWishList(product: product)
        }
    }
}
