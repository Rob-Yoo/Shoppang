//
//  SearchResultViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import Combine

final class SearchResultViewController: BaseViewController<SearchResultRootView> {

    private let query: String
    private let model = SearchResultModel()
    private var cancellable = Set<AnyCancellable>()
    
    init(query: String) {
        self.query = query
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = query
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.makeToastActivity(.center)
        self.addUserAction()
        self.observeModel()
        self.model.searchingProduct = query
    }
    
    private func addUserAction() {
        self.addActionToSearchResultCollectionView()
        self.addActionToSortButtonsView()
    }
    
    private func addActionToSearchResultCollectionView() {
        self.contentView.productListCollectionView.prefetchDataSource = self
        self.contentView.productListCollectionView.delegate = self
    }
    
    private func addActionToSortButtonsView() {
        self.contentView.sortButtonsView.sortButtonsViewDelegate = self
    }
}

//MARK: - User Action Handling
extension SearchResultViewController: UICollectionViewDataSourcePrefetching, UICollectionViewDelegate, SortButtonsViewDelegate, SearchResultCollectionViewCellDelegate, ProductDetailViewControllerDelegate {
    
    func sortButtonTapped(type newType: SortType) {
        guard self.model.sortType != newType else { return }
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
    
    func showInvalidUrlToast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.contentView.makeToast("🚨 해당 사이트의 주소가 없거나 유효하지 않아요", duration: 1.5)
        }
    }
}


//MARK: - Observing Model
extension SearchResultViewController {
    private func observeModel() {
        self.model.$searchResult
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.contentView.hideToastActivity()
                self?.contentView.update(searchResult: new)
            }
            .store(in: &cancellable)
        
        self.model.$cartList
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.contentView.productListCollectionView.cartList = new
            }
            .store(in: &cancellable)
    }
}
