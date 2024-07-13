//
//  SearchResultRepository.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/13/24.
//

import Foundation

final class SearchResultRepository {
    let searchKeyword: String
    var sortType: SortType = .sim {
        didSet {
            page = 1
        }
    }
    var page: Int = 1
    var isValidPagination: Bool {
        guard 1 < page && page <= 1000, let prev = self.prevSearchResult else { return false }
        guard page * prev.display <= prev.total else { return false }
        return true
    }
    
    private var total = -1
    private var prevSearchResult: Shopping?
    private var request: NaverRequest {
        return .shopping(query: searchKeyword, sort: sortType.rawValue, start: page)
    }
    
    init(searchKeyword: String) {
        self.searchKeyword = searchKeyword
    }

    func fetchSearchResult() async -> SearchResultModel? {
        guard let searchResult = await NetworkManager.shared.requestAPI(req: request, type: Shopping.self) else { return nil }
        
        if (total == -1) { total = searchResult.total }
        self.prevSearchResult = searchResult
        return SearchResultModel(total: total, productList: searchResult.items, isPagination: page > 1)
    }
}
