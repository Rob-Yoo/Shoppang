//
//  Shopping.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import Foundation

struct Shopping: Decodable {
    let total: Int
    let start: Int
    let display: Int
    var items: [Product]
}
