//
//  SearchResultViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import Toast

final class SearchResultViewController: BaseViewController<SearchResultRootView> {
    
    private let viewModel: SearchResultViewModel
    
    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.inputViewDidLoadTrigger.value = ()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.inputViewDidAppearTrigger.value = ()
    }
    
    override func addUserAction() {
        self.contentView.productListCollectionView.prefetchDataSource = self
        self.contentView.productListCollectionView.delegate = self
        self.contentView.productListCollectionView.dataSource = self
        self.contentView.sortButtonsView.sortButtonsViewDelegate = self
    }
    
    override func bindViewModel() {
        self.viewModel.outputWillFetchData.bind { [weak self] searchKeyword in
            guard let searchKeyword = searchKeyword else { return }
            self?.navigationItem.title = searchKeyword
            self?.contentView.makeToastActivity(.center)
        }
        
        self.viewModel.outputTotalCount.bind { [weak self] count in
            guard let count = count else { return }
            self?.contentView.totalCountLabel.text = count.formatted() + "개의 검색 결과"
        }
        
        self.viewModel.outputProductList.bind { [weak self] productList in
            self?.contentView.hideToastActivity()
            self?.contentView.productListCollectionView.reloadData()
        }
        
        self.viewModel.outputShouldScrollUp.bind { [weak self] shouldScrollUp in
            if shouldScrollUp != nil {
                self?.contentView.productListCollectionView.scrollUpToTop()
            }
        }
    }
}

//MARK: - CollectionView Delegate/DataSource/Prefatching
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.outputProductList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productList = self.viewModel.outputProductList.value
        let product = productList[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reusableIdentifier, for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCellData(data: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let productList = self.viewModel.outputProductList.value

        for indexPath in indexPaths {
            if productList.count - 2 == indexPath.item {
                self.contentView.makeToastActivity(.center)
                self.viewModel.inputPage.value += 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.viewModel.outputProductList.value[indexPath.row]
//        let nextVC = ProductDetailViewController(product: product, model: WishListModel())
        
//        nextVC.productDetailViewControllerDelegate = self
//        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: - User Action Handling
extension SearchResultViewController: SortButtonsViewDelegate, ProductCollectionViewCellDelegate, ProductDetailViewControllerDelegate {
    
    func sortButtonTapped(type newType: SortType) {
        guard self.viewModel.inputSortType.value != newType else { return }

        self.contentView.hideToastActivity() // 스크롤 시 생기는 Indicator 삭제
        self.contentView.makeToastActivity(.center)
        self.viewModel.inputSortType.value = newType
    }
    
    func wishButtonTapped(idx: Int) {
        self.viewModel.inputWishButtonTapped.value = idx
    }
    
    func showInvalidUrlToast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.contentView.makeToast("🚨 해당 사이트의 주소가 없거나 유효하지 않아요", duration: 1.5)
        }
    }
}
