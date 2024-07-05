//
//  SearchResultViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import Combine

final class SearchResultViewController: BaseViewController<SearchResultRootView> {
    
    private let model: SearchResultModel
    private var cancellable = Set<AnyCancellable>()
    
    init(model: SearchResultModel) {
        self.model = model
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.model.searchingProduct
        self.contentView.makeToastActivity(.center)
    }
    
    override func addUserAction() {
        self.contentView.productListCollectionView.prefetchDataSource = self
        self.contentView.productListCollectionView.delegate = self
        self.contentView.productListCollectionView.dataSource = self
        self.contentView.sortButtonsView.sortButtonsViewDelegate = self
    }
    
    override func observeModel() {
        self.model.$searchResult
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.contentView.hideToastActivity()
                
                guard new.start != -1 else { return }
                let isNew = (!new.items.isEmpty && self?.model.page == 1) ? true : false
        
                self?.contentView.update(searchResult: new)
                self?.contentView.productListCollectionView.update(isNew: isNew)
            }
            .store(in: &cancellable)
        
        self.model.$cartList
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
        return self.model.searchResult.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productList = self.model.searchResult.items
        let product = productList[indexPath.item]
        let cartList = self.model.cartList
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.reusableIdentifier, for: indexPath) as? SearchResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCellData(data: product, isCart: cartList.contains(product.productId))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if self.model.searchResult.items.count - 2 == indexPath.item {
                self.model.page += 1
                self.contentView.makeToastActivity(.center)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.model.searchResult.items[indexPath.item]
        let isCart = self.model.cartList.contains(product.productId)
        let nextVC = ProductDetailViewController(product: product, model: self.model, isCart: isCart)
        
        nextVC.productDetailViewControllerDelegate = self
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: - User Action Handling
extension SearchResultViewController: SortButtonsViewDelegate, SearchResultCollectionViewCellDelegate, ProductDetailViewControllerDelegate {
    
    func sortButtonTapped(type newType: SortType) {
        guard self.model.sortType != newType else { return }
        self.contentView.hideToastActivity() // 스크롤 시 생기는 Indicator 삭제
        self.contentView.makeToastActivity(.center)
        self.model.sortType = newType
    }
    
    func cartButtonTapped(idx: Int) {
        let productID = self.model.searchResult.items[idx].productId
        
        if (self.model.cartList.contains(productID)) {
            self.model.removeFromCartList(productID: productID)
        } else {
            self.model.addToCartList(productID: productID)
        }
    }
    
    func showInvalidUrlToast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.contentView.makeToast("🚨 해당 사이트의 주소가 없거나 유효하지 않아요", duration: 1.5)
        }
    }
}
