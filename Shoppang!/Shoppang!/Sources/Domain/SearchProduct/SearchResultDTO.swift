//
//  SearchResultDTO.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import Foundation

struct SearchResultDTO: Decodable {
    let total: Int
    let start: Int
    let display: Int
    var items: [Product]
    
    private init(total: Int, start: Int, display: Int, items: [Product]) {
        self.total = total
        self.start = start
        self.display = display
        self.items = items
    }
    
    init() {
        self.init(total: 0, start: 0, display: 0, items: [])
    }
}

struct Product: Decodable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let mallName: String
    let productId: String
}
