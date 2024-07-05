//
//  SearchResultViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import Combine

final class SearchResultViewController: BaseViewController<SearchResultRootView> {
    
    private let searchResultModel: SearchResultModel
    private let cartListModel: CartListModel
    private var cancellable = Set<AnyCancellable>()
    
    init(searchResultModel: SearchResultModel, cartListModel: CartListModel) {
        self.searchResultModel = searchResultModel
        self.cartListModel = cartListModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.searchResultModel.searchingProduct
        self.contentView.makeToastActivity(.center)
    }
    
    override func addUserAction() {
        self.contentView.productListCollectionView.prefetchDataSource = self
        self.contentView.productListCollectionView.delegate = self
        self.contentView.productListCollectionView.dataSource = self
        self.contentView.sortButtonsView.sortButtonsViewDelegate = self
    }
    
    override func observeModel() {
        self.searchResultModel.$searchResult
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.contentView.hideToastActivity()
                
                guard new.start != -1 else { return }
                let isNew = (!new.items.isEmpty && self?.searchResultModel.page == 1) ? true : false
        
                self?.contentView.update(searchResult: new)
                self?.contentView.productListCollectionView.update(isNew: isNew)
            }
            .store(in: &cancellable)
        
        self.cartListModel.$cartList
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.contentView.productListCollectionView.reloadData()
            }
            .store(in: &cancellable)
    }
}

//MARK: - CollectionView Delegate/DataSource/Prefatching
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchResultModel.searchResult.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productList = self.searchResultModel.searchResult.items
        let product = productList[indexPath.item]
        let cartList = self.cartListModel.cartList
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.reusableIdentifier, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCellData(data: product, isCart: self.cartListModel.isCart(productID: product.productId))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if self.searchResultModel.searchResult.items.count - 2 == indexPath.item {
                self.searchResultModel.page += 1
                self.contentView.makeToastActivity(.center)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.searchResultModel.searchResult.items[indexPath.item]
        let isCart = self.cartListModel.isCart(productID: product.productId)
        let nextVC = ProductDetailViewController(product: product, model: self.cartListModel)
        
        nextVC.productDetailViewControllerDelegate = self
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: - User Action Handling
extension SearchResultViewController: SortButtonsViewDelegate, SearchResultCollectionViewCellDelegate, ProductDetailViewControllerDelegate {
    
    func sortButtonTapped(type newType: SortType) {
        guard self.searchResultModel.sortType != newType else { return }
        self.contentView.hideToastActivity() // 스크롤 시 생기는 Indicator 삭제
        self.contentView.makeToastActivity(.center)
        self.searchResultModel.sortType = newType
    }
    
    func cartButtonTapped(idx: Int) {
        let product = self.searchResultModel.searchResult.items[idx]
        let isCart = self.cartListModel.isCart(productID: product.productId)
        
        if (isCart) {
            self.cartListModel.removeFromCartList(productID: product.productId)
        } else {
            self.cartListModel.addToCartList(product: product)
        }
    }
    
    func showInvalidUrlToast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.contentView.makeToast("🚨 해당 사이트의 주소가 없거나 유효하지 않아요", duration: 1.5)
        }
    }
}
