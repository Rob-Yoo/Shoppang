//
//  Shopping.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import Foundation

// DTO1, DTO2 --> Entity
struct ShoppingDTO: Decodable {
    let total: Int
    let start: Int
    let display: Int
    var items: [ProductDTO]
}
