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
    
    private let repository = WishListRepository()
    
    init() {
        self.wishList = repository.fetchAll()
    }

}

//MARK: - Data Fetching
extension WishListModel {
    private func reloadData() {
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
