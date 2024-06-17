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
        self.configureNavigationTitle()
        self.addUserAction()
        self.observeModel()
    }
    
    private func configureNavigationTitle() {
        self.navigationItem.title = self.navigationTitle
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
        let nextVC = ProductDetailViewController(product: product)
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchResultViewController: SortButtonsViewDelegate {
    func sortButtonTapped(type: SortType) {
        self.model.sortType = type
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
    }
}
