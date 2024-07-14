//
//  ProductModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/14/24.
//

import Foundation

struct ProductModel: Hashable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    let productId: String
    var isWishList: Bool
    
    static func createProductModel(_ product: Product, isWishList: Bool) -> ProductModel {
        return ProductModel(title: product.title, link: product.link, image: product.image, lprice: product.lprice, mallName: product.mallName, productId: product.productId, isWishList: isWishList)
    }
    
    static func createProductModel(_ product: WishProduct) -> ProductModel {
        return ProductModel(title: product.title, link: product.link, image: product.image, lprice: product.lprice, mallName: product.mallName, productId: product.productId, isWishList: true)
    }
    
    static func ==(lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.productId == rhs.productId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(productId)
    }
}
