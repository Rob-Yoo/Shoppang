//
//  AppleProductModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import Foundation
import Combine

final class AppleProductModel {
    @Published var appleProductList = [SearchResultDTO]()
    
    init() {
        let urls = AppleProductType.allCases.map { $0.url }
        self.fetchAppleProductResult(urls: urls)
    }
    
}

extension AppleProductModel {
    private func fetchAppleProductResult(urls: [String]) {
        var productList = Array(repeating: SearchResultDTO(), count: AppleProductType.allCases.count)
        let group = DispatchGroup()
        
        for (idx, url) in urls.enumerated() {
            group.enter()
            DispatchQueue.global().async(group: group) {
                NetworkManager.requestURL(url: url) { (result: SearchResultDTO) in
                    productList[idx] = result
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.appleProductList = productList
        }
    }
}
