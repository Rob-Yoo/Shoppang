//
//  SearchResultModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import Foundation
import Combine

final class SearchResultModel {
    @Published var searchResult = SearchResult()

    var searchingProduct: String {
        willSet {
            self.fetchSearchResult(query: newValue, sort: sortType)
        }
    }
    
    var sortType: SortType = .sim {
        willSet {
            self.fetchSearchResult(query: searchingProduct, sort: newValue)
        }
    }
    
    var page = 1 {
        didSet {
            // 페이지네이션이 아닌 경우 guard
            guard 1 < page && page <= 1000 else {
                return
            }
            
            // 마지막 페이지가 아닌 경우 guard
            guard page * searchResult.display <= searchResult.total else {
                self.searchResult = SearchResult()
                return
            }
            
            self.fetchSearchResult(query: searchingProduct, sort: sortType, page: page, isPagination: true)
        }
    }
    
    init(query: String) {
        self.searchingProduct = query
        self.fetchSearchResult(query: query, sort: .sim)
    }
}

//MARK: - Data Manipulation
extension SearchResultModel {
    
    private func fetchSearchResult(query: String, sort: SortType, page: Int = 1 , isPagination: Bool = false) {
        let url = API.searchProductURL(query: query, sort: sort.rawValue, page: page)
        
        let success: (SearchResult) -> Void = { [weak self] result in
            if (isPagination) {
                self?.searchResult.items.append(contentsOf: result.items)
            } else {
                self?.searchResult = result
                self?.page = 1
            }
        }
        
        let failure: (Error) -> Void = { [weak self] _ in
            self?.searchResult = SearchResult()
        }

        NetworkManager.requestURL(url: url, success: success, failure: failure)
    }
}
