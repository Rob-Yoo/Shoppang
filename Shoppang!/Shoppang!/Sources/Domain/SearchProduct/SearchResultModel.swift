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
    var searchingProduct = "" {
        willSet {
            let url = API.searchProductURL(query: newValue, sort: self.sortType.rawValue)
            self.fetchSearchResult(url: url)
        }
    }
    
    var sortType: SortType = .sim {
        willSet {
            let url = API.searchProductURL(query: self.searchingProduct, sort: newValue.rawValue)
            self.fetchSearchResult(url: url)
        }
    }
    
    private func fetchSearchResult(url: String, isAppend: Bool = false) {
//        NetworkManager.requestURL(url: url) { [weak self] (result: SearchResultDTO) in
//            if (isAppend) {
//                self?.searchResult.items.append(contentsOf: result.items)
//            } else {
//                self?.searchResult = result
//            }
//        }
        NetworkManager.requestURL(url: url) { [weak self] (result: SearchResultDTO) in
            print(result)
        }
    }
}

extension SearchResultModel {
    enum SortType: String {
        case sim
        case date
        case asc
        case dsc
    }
}
