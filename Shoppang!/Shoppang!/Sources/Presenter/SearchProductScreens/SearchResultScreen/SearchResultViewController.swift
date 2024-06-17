//
//  SearchResultViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import Combine

final class SearchResultViewController: BaseViewController<SearchResultRootView> {

    private let navigationTitle: String
    private let model = SearchResultModel()
    private var cancellable = Set<AnyCancellable>()
    
    init(query: String) {
        self.navigationTitle = query
        super.init(nibName: nil, bundle: nil)
        self.model.searchingProduct = query
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.navigationTitle
        self.addUserAction()
        self.observeModel()
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
extension SearchResultViewController: UICollectionViewDataSourcePrefetching, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if self.model.searchResult.items.count - 2 == indexPath.item {
                self.model.page += 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.model.searchResult.items[indexPath.item]
        let isCart = self.model.cartList.contains(product.productId)
        let nextVC = ProductDetailViewController(product: product, model: self.model, isCart: isCart)
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchResultViewController: SortButtonsViewDelegate, SearchResultCollectionViewCellDelegate {
    
    func sortButtonTapped(type: SortType) {
        self.model.sortType = type
    }
    
    func cartButtonTapped(idx: Int) {
        let productID = self.model.searchResult.items[idx].productId
        
        if (self.model.cartList.contains(productID)) {
            self.model.removeFromCartList(productID: productID)
        } else {
            self.model.addToCartList(productID: productID)
        }
    }
}


//MARK: - Observing Model
extension SearchResultViewController {
    private func observeModel() {
        self.model.$searchResult
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
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
