//
//  WishListModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import Foundation
import Combine

final class WishListModel {
    @Published var wishList: [Product] {
        didSet {
            let wishListCount = wishList.count
            UserDefaults.standard.setValue(wishListCount, forKey: UserDefaultsKey.userWishListCount.rawValue)
        }
    }
    
    private var willDeleteWishList = [Product]()
    
    private let repository = WishListRepository()
    
    init() {
        self.wishList = repository.fetchAll()
    }

}

//MARK: - Data Fetching
extension WishListModel {
    func reloadData() {
        self.wishList = repository.fetchAll()
    }
    
    func addToWishList(product: Product) {
        self.repository.createItem(product: product)
        self.reloadData()
    }
    
    func removeFromWishList(productID: String) {
        self.repository.deleteItem(productID: productID)
        self.reloadData()
    }
        
    func isWishList(productID: String) -> Bool {
        guard let _ = self.wishList.first(where: {
            $0.productId == productID
        }) else { return false }
        
        return true
    }
}

//MARK: - Add/Delete Pending
extension WishListModel {
    
    func isWillDeleteWishList(product: Product) -> Bool {
        guard let _ = self.willDeleteWishList.first(where: {
            $0.productId == product.productId
        }) else { return false }
        
        return true
    }
    
    func addToWillDeleteWishList(product: Product) {
        self.willDeleteWishList.append(product)
    }
    
    func removeToWillDeleteWishList(product: Product) {
        self.willDeleteWishList = willDeleteWishList.filter { $0.productId != product.productId }
    }
    
    func removePendingWishList() {
        self.willDeleteWishList.forEach { self.repository.deleteItem(productID: $0.productId) }
        self.reloadData()
    }

}

//MARK: - Sorting
extension WishListModel {
    func sortWishList(type: WishListSortType) {
        switch type {
        case .add:
            self.reloadData()
        case .asc:
            self.wishList = wishList.sorted { Int($0.lprice)! < Int($1.lprice)! }
        case .dsc:
            self.wishList = wishList.sorted { Int($0.lprice)! > Int($1.lprice)! }
        case .mallName:
            self.wishList = wishList.sorted { $0.mallName < $1.mallName }
        }
    }
}
