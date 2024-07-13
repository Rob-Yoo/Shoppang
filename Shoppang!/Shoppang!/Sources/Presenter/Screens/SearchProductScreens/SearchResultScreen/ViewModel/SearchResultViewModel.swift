//
//  SearchResultViewModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import Foundation
import Combine

final class SearchResultViewModel {
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputViewDidAppearTrigger: Observable<Void?> = Observable(nil)
    var inputSortType: Observable<SortType> = Observable(.sim)
    var inputPage: Observable<Int> = Observable(1)
    var inputWishButtonTapped: Observable<Int?> = Observable(nil)
    
    var outputWillFetchData: Observable<String?> = Observable(nil)
    var outputTotalCount: Observable<Int?> = Observable(nil)
    var outputProductList: Observable<[ProductModel]> = Observable([])
    var outputShouldScrollUp: Observable<Void?> = Observable(nil)
    var outputCollectionViewReloadTrigger: Observable<Void?> = Observable(nil)
    
    private var repository: SearchResultRepository
    
    init(searchKeyword: String) {
        self.repository = SearchResultRepository(searchKeyword: searchKeyword)
        self.transform()
    }
    
    private func transform() {
        self.inputViewDidLoadTrigger.bind { [weak self] signal in
            if (signal != nil), let self = self {
                self.outputWillFetchData.value = self.repository.searchKeyword
                Task { await self.fetchData() }
            }
        }
        
        self.inputSortType.bind { [weak self] type in
            self?.changeSortType(type: type)
        }
        
        self.inputPage.bind { [weak self] page in
            self?.doPagination(page: page)
        }
        
        self.inputWishButtonTapped.bind { [weak self] index in
            guard let index = index else { return }
            self?.updateWishList(idx: index)
        }
        
        self.inputViewDidAppearTrigger.bind { [weak self] _ in
            self?.reloadWishList()
        }
    }
}

//MARK: - Transform Methods
extension SearchResultViewModel {
    private func fetchData() async {
        guard let searchResult = await repository.fetchSearchResult() else { return }
        
        DispatchQueue.main.async { [weak self] in
            if (self?.outputTotalCount.value == nil) {
                self?.outputTotalCount.value = searchResult.total
            }
            
            if (searchResult.isPagination) {
                self?.outputProductList.value.append(contentsOf: searchResult.productList)
            } else {
                self?.outputProductList.value = searchResult.productList
                
                if (!searchResult.productList.isEmpty) {
                    self?.outputShouldScrollUp.value = ()                    
                }
            }
        }
    }
    
    private func changeSortType(type: SortType) {
        guard inputViewDidLoadTrigger.value != nil else { return }

        self.repository.sortType = type
        Task { await self.fetchData() }
    }
    
    private func doPagination(page: Int) {
        self.repository.page = page
        if (repository.isValidPagination) {
            Task { await self.fetchData() }
        } else {
            self.outputProductList.value = self.outputProductList.value
        }
    }
    
    private func updateWishList(idx: Int) {
        let selectedProduct = self.outputProductList.value[idx]
        let isWishList = selectedProduct.isWishList
        
        if (isWishList) {
            self.repository.removeFromWishList(productID: selectedProduct.productId)
        } else {
            self.repository.addToWishList(product: selectedProduct)
        }
        
        self.outputProductList.value[idx].isWishList.toggle()
    }
}

extension SearchResultViewModel {
    private func reloadWishList() {
        var productList = self.outputProductList.value

        self.repository.reloadWishList { (wishList: [ProductModel]) in
            for (idx, product) in productList.enumerated() where product.isWishList {
                if !(wishList.contains(where: { $0.productId == product.productId })) {
                    productList[idx].isWishList.toggle()
                }
            }
            
            self.outputProductList.value = productList
        }
    }
}
