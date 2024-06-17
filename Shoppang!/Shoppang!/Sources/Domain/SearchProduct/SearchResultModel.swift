//
//  SearchResultModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import Foundation
import Combine

final class SearchResultModel {
    @Published var searchResult = SearchResultDTO()
    var searchingProduct: String = "" {
        willSet {
            let url = API.searchProductURL(query: newValue, sort: self.sortType.rawValue, page: 1)
            self.page = 1
            self.fetchSearchResult(url: url)
        }
    }
    
    var sortType: SortType = .sim {
        willSet {
            let url = API.searchProductURL(query: self.searchingProduct, sort: newValue.rawValue, page: 1)
            self.page = 1
            self.fetchSearchResult(url: url)
        }
    }
    
    var page = 1 {
        willSet {
            guard page <= 1000 else { return }
            guard page * searchResult.display <= searchResult.total else { return }
            
            let url = API.searchProductURL(query: self.searchingProduct, sort: self.sortType.rawValue, page: newValue)
            self.fetchSearchResult(url: url, isAppend: true)
        }
    }
}

//MARK: - Data Manipulation
extension SearchResultModel {
    private func fetchSearchResult(url: String, isAppend: Bool = false) {
        NetworkManager.requestURL(url: url) { [weak self] (result: SearchResultDTO) in
            if (isAppend) {
                self?.searchResult.items.append(contentsOf: result.items)
            } else {
                self?.searchResult = result
            }
        }
    }
}
