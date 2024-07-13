//
//  SearchResultModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import Foundation
import Combine

final class SearchResultViewModel {
    private var searchKeyword: String
    private var url: String {
        let query = searchKeyword
        let sort = inputSortType.value.rawValue
        let start = inputPage.value
        
        return API.searchProductURL(query: query, sort: sort, page: start)
    }
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputViewDidAppearTrigger: Observable<Void?> = Observable(nil)
    var inputSelectItemIndex: Observable<Int?> = Observable(nil)
    var inputSortType: Observable<SortType> = Observable(.sim)
    var inputPage: Observable<Int> = Observable(1)
    
    var outputWillFetchData: Observable<String> = Observable("")
    var outputSearchResult: Observable<SearchResult> = Observable(SearchResult())
    var outputWillMoveToProductDetail: Observable<Product?> = Observable(nil)
    
    init(searchKeyword: String) {
        self.searchKeyword = searchKeyword
    }
    
    private func transform() {
        self.inputViewDidLoadTrigger.bind { [weak self] signal in
            if (signal != nil), let self = self {
                self.outputWillFetchData.value = self.searchKeyword
                self.fetchData()
            }
        }
        
        self.inputSelectItemIndex.bind { [weak self] index in
            guard let idx = index else { return }
            self?.findProduct(idx: idx)
        }
        
        self.inputSortType.bind { [weak self] type in
            self?.changeSortType(type: type)
        }
        
        self.inputPage.bind { [weak self] page in
            self?.doPagination(page: page)
        }
    }
}

//MARK: - Transform Methods
extension SearchResultViewModel {
    private func fetchData() {
        let isPagination = (inputPage.value > 1)
        let success = { [weak self] (result: SearchResult) -> Void in
            if (isPagination) {
                self?.outputSearchResult.value.items.append(contentsOf: result.items)
            } else {
                self?.outputSearchResult.value = result
            }
        }
        let failure = { [weak self] (_: Error) -> Void in
            self?.outputSearchResult.value = SearchResult()
        }
        
        NetworkManager.requestAPI(url: url, success: success, failure: failure)
    }
    
    private func findProduct(idx: Int) {
        let productList = self.outputSearchResult.value.items
        let product = productList[idx]
        
        self.outputWillMoveToProductDetail.value = product
    }
    
    private func changeSortType(type: SortType) {
        guard inputViewDidLoadTrigger.value != nil else { return }
        self.inputPage.value = 1
        self.fetchData()
    }
    
    private func doPagination(page: Int) {
        // 페이지네이션이 아닌 경우 guard
        guard 1 < page && page <= 1000 else { return }
        
        // 마지막 페이지인데도 불구하고 계속 페이지네이션을 시도하면 guard
        guard page * outputSearchResult.value.display <= outputSearchResult.value.total else {
            self.outputSearchResult.value = SearchResult()
            return
        }
        
        self.fetchData()
    }
}
