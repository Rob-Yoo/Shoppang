//
//  AppleProductModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import Foundation
import Combine

final class AppleProductModel {
    @Published var appleProductList = [SearchResult]()
}

extension AppleProductModel {
    func fetchAppleProductResult() {
        let urls = AppleProductType.allCases.map { $0.url }
        var productList = Array(repeating: SearchResult(), count: AppleProductType.allCases.count)

        let group = DispatchGroup()
        
        for (idx, url) in urls.enumerated() {
            group.enter()
            DispatchQueue.global().async(group: group) {
                NetworkManager.requestURL(url: url){ (result: SearchResult) in
                    productList[idx] = result
                    group.leave()
                } failure: { _ in
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.appleProductList = productList
        }
    }
}
