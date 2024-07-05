//
//  CartListViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import UIKit
import Combine

final class CartListViewController: BaseViewController<CartListRootView> {
    
    private let model: CartListModel
    private var cancellable = Set<AnyCancellable>()
    
    init(model: CartListModel) {
        self.model = model
        super.init()
    }
    
    override func addUserAction() {
        self.contentView.productCollectionView.delegate = self
        self.contentView.productCollectionView.dataSource = self
    }
    
    override func observeModel() {
        self.model.$cartList
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.contentView.productCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}

//MARK: - CollectionView Delegate/DataSource
extension CartListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.cartList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = self.model.cartList[indexPath.item]
        let isCart = self.model.isCart(productID: product.productId)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reusableIdentifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(data: product, isCart: isCart)
        return cell
    }

}

//MARK: - User Action Handling
extension CartListViewController: ProductCollectionViewCellDelegate {
    func cartButtonTapped(idx: Int) {
        let product = self.model.cartList[idx]
        let isCart = self.model.isCart(productID: product.productId)

        if (isCart) {
            self.model.removeFromCartList(productID: product.productId)
        } else {
            self.model.addToCartList(product: product)
        }
    }
}
