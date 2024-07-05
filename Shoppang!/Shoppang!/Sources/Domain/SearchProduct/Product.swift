//
//  Product.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import Foundation

struct Product: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    let productId: String
    
    static func createProduct(dto: CartProductDTO) -> Self {
        return Product(title: dto.title, link: dto.link, image: dto.image, lprice: dto.lprice, mallName: dto.mallName, productId: dto.productId)
    }
}
