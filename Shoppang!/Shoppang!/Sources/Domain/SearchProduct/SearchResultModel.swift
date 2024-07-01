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
    
    @Published var cartList = loadCartList() {
        didSet {
            let cart = Array(cartList)
            UserDefaults.standard.setValue(cart, forKey: UserDefaultsKey.userCartList.rawValue)
        }
    }

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
            
            let url = API.searchProductURL(query: self.searchingProduct, sort: self.sortType.rawValue, page: page)
            self.fetchSearchResult(url: url, isAppend: true)
        }
    }
}

//MARK: - Data Manipulation
extension SearchResultModel {
    private func fetchSearchResult(url: String, isAppend: Bool = false) {
        let success: (SearchResult) -> Void = { [weak self] result in
            if (isAppend) {
                self?.searchResult.items.append(contentsOf: result.items)
            } else {
                self?.searchResult = result
            }
        }
        
        let failure: (Error) -> Void = { [weak self] _ in
            self?.searchResult = SearchResult()
        }

        NetworkManager.requestURL(url: url, success: success, failure: failure)
    }
}

//MARK: - Cart List Manipulation
extension SearchResultModel {
    static private func loadCartList() -> Set<String> {
        guard let cartList = UserDefaults.standard.array(forKey: UserDefaultsKey.userCartList.rawValue) as? [String] else {
            return Set<String>()
        }
        
        return Set(cartList)
    }
}

//MARK: - CartProtocol Implemetation
extension SearchResultModel: CartProtocol {
    func addToCartList(productID: String) {
        self.cartList.insert(productID)
    }
    
    func removeFromCartList(productID: String) {
        self.cartList.remove(productID)
    }
}
