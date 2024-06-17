//
//  CartProtocol.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation

protocol CartProtocol {
    func addToCartList(productID: String)
    func removeFromCartList(productID: String)
}
