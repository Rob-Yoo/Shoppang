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
        guard 1 < page && page <= 1000, let prev = self.prevShopping else { return false }
        guard page * prev.display <= prev.total else { return false }
        return true
    }
    
    private var total = -1
    private var prevShopping: Shopping?
    private var request: NaverRequest {
        return .shopping(query: searchKeyword, sort: sortType.rawValue, start: page)
    }
    private let wishListRepository = WishListRepository()

    init(searchKeyword: String) {
        self.searchKeyword = searchKeyword
    }
}

//MARK: - Fetch Data By Network
extension SearchResultRepository {
    func fetchSearchResult() async -> SearchResultModel? {
        guard let shopping = await NetworkManager.shared.requestAPI(req: request, type: Shopping.self) else { return nil }
        
        if (total == -1) { total = shopping.total }
        self.prevShopping = shopping
        return await self.convertToSearchResultModel(shopping: shopping)
    }
    
    @MainActor
    // Realm 객체 생성 스레드와 접근하는 스레드가 같아야하기 때문에 Main Thread에서 접근할 수 있게 @MainActor 붙혀줌
    private func convertToSearchResultModel(shopping: Shopping) -> SearchResultModel {
        let productList = shopping.items
        let wishList = Set(self.wishListRepository.fetchAllProduct())
        let isPagination = self.page > 1
        var result = [ProductModel]()

        for product in productList {
            let isWishList = wishList.contains(product)
            let converted = ProductModel.createProductModel(product, isWishList: isWishList)
            result.append(converted)
        }
        
        return SearchResultModel(total: self.total, productList: result, isPagination: isPagination)
    }
}

// MARK: - Fetch Data By Realm
extension SearchResultRepository {
    func addToWishList(product: ProductModel) {
        self.wishListRepository.createItem(product: product)
    }

    func removeFromWishList(productID: String) {
        self.wishListRepository.deleteItem(productID: productID)
    }
    
    func reloadWishList(closure: ([ProductModel]) -> Void) {
        let wishList = self.wishListRepository.fetchAllProductModel()
        closure(wishList)
    }
}
