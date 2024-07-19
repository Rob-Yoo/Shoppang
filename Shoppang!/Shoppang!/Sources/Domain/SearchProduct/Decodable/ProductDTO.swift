//
//  Product.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import Foundation

struct ProductDTO: Decodable, Hashable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    let productId: String
}
