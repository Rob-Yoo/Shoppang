//
//  CartListModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import Foundation
import Combine

final class CartListModel {
    @Published var cartList: Set<CartProductDTO> {
        didSet {
            let cartListCount = cartList.count
            UserDefaults.standard.setValue(cartListCount, forKey: UserDefaultsKey.userCartListCount.rawValue)
        }
    }
    
    private let repository = CartListRepository()
    
    init() {
        self.cartList = repository.fetchAll()
    }

}

//MARK: - Data Fetching
extension CartListModel {
    private func reloadData() {
        self.cartList = repository.fetchAll()
    }
    
    func addToCartList(product: Product) {
        self.repository.createItem(data: CartProductDTO(product: product))
        self.reloadData()
    }
    
    func removeFromCartList(productID: String) {
        guard let product = self.cartList.first(where: {
            $0.productId == productID
        }) else { return }

        self.repository.deleteItem(product: product)
        self.reloadData()
    }
    
    func isCart(productID: String) -> Bool {
        guard let product = self.cartList.first(where: {
            $0.productId == productID
        }) else { return false }
        
        return self.cartList.contains(product)
    }
}
