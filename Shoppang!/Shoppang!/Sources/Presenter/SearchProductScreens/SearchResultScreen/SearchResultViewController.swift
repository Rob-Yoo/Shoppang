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
        self.model.searchingProduct = query
    }
    
    override func addUserAction() {
        self.contentView.productListCollectionView.prefetchDataSource = self
        self.contentView.productListCollectionView.delegate = self
        self.contentView.sortButtonsView.sortButtonsViewDelegate = self
    }
    
    override func observeModel() {
        self.model.$searchResult
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.contentView.hideToastActivity()
                if (new.start != -1) {
                    self?.contentView.update(searchResult: new)
                }
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

//MARK: - User Action Handling
extension SearchResultViewController: UICollectionViewDataSourcePrefetching, UICollectionViewDelegate, SortButtonsViewDelegate, SearchResultCollectionViewCellDelegate, ProductDetailViewControllerDelegate {
    
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
