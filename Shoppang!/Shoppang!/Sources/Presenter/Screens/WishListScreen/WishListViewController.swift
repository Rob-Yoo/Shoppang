//
//  WishListViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import UIKit
import Combine

final class WishListViewController: BaseViewController<WishListRootView> {
    
    private let viewModel: WishListViewModel
    private var cancellable = Set<AnyCancellable>()
    
    init(viewModel: WishListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.inputViewWillAppearTrigger.value = ()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.inputViewWillDisappearTrigger.value = ()
    }
    
    override func addUserAction() {
        self.contentView.wishListCollectionView.delegate = self
        self.contentView.wishListCollectionView.dataSource = self
        self.contentView.transparentButton.menu = makePullDownMenu()
    }
    
    override func bindViewModel() {
        self.viewModel.outputWishList.bind { [weak self] wishList in
            self?.contentView.update(wishListCount: wishList.count)
            self?.contentView.wishListCollectionView.reloadData()
        }
        
        self.viewModel.outputWishListSortType.bind { [weak self] type in
            self?.contentView.update(sortType: type)
        }
    }
}

//MARK: - CollectionView Delegate/DataSource
extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.outputWishList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = self.viewModel.outputWishList.value[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reusableIdentifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(data: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let product = self.viewModel.outputWishList.value[indexPath.item]
//        let nextVC = ProductDetailViewController(product: product, model: self.model)
//        
//        nextVC.productDetailViewControllerDelegate = self
//        self.navigationController?.pushViewController(nextVC, animated: true)
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
        let product = self.viewModel.outputWishList.value[idx]
        self.viewModel.inputWishButtonTapped.value = product
    }
    
    private func makePullDownMenu() -> UIMenu {
        let actions = WishListSortType.allCases.map {
            let sortType = $0
            return UIAction(title: sortType.title) { [weak self] _ in
                self?.viewModel.inputWishListSortType.value = sortType
            }
        }
        
        return UIMenu(children: actions)
    }
}
