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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.model.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.model.removePendingWishList()
    }
    
    override func addUserAction() {
        self.contentView.wishListCollectionView.delegate = self
        self.contentView.wishListCollectionView.dataSource = self
        self.contentView.transparentButton.menu = makePullDownMenu()
    }
    
    override func observeModel() {
        self.model.$wishList
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.contentView.update(wishListCount: new.count)
                self?.contentView.wishListCollectionView.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.model.wishList[indexPath.item]
        let nextVC = ProductDetailViewController(product: product, model: self.model)
        
        nextVC.productDetailViewControllerDelegate = self
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

//MARK: - User Action Handling
extension WishListViewController: ProductCollectionViewCellDelegate, ProductDetailViewControllerDelegate {
    
    func showInvalidUrlToast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.contentView.makeToast("🚨 해당 사이트의 주소가 없거나 유효하지 않아요", duration: 1.5)
        }
    }
    
    func wishButtonTapped(idx: Int) {
        let product = self.model.wishList[idx]
        let isWishList = !self.model.isWillDeleteWishList(product: product)

        if (isWishList) {
            // 위시 리스트라면 버퍼에 저장
            self.model.addToWillDeleteWishList(product: product)
        } else {
            // 아니라면 버퍼에서 삭제
            self.model.removeToWillDeleteWishList(product: product)
        }
        
        let indexPath = IndexPath(item: idx, section: 0)
        guard let wishListCountCell = contentView.wishListCollectionView.cellForItem(at: indexPath) as? ProductCollectionViewCell else { return }
        
        wishListCountCell.configureCellData(data: product, isWishList: !isWishList)
    }
    
    private func makePullDownMenu() -> UIMenu {
        let actions = WishListSortType.allCases.map {
            let sortType = $0
            return UIAction(title: sortType.title) { [weak self] _ in
                self?.model.sortWishList(type: sortType)
                self?.contentView.update(sortType: sortType)
            }
        }
        
        return UIMenu(children: actions)
    }
}
