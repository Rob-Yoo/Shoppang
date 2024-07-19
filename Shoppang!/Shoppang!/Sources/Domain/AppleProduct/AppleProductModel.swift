//
//  AppleProductModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import Foundation
import Combine

final class AppleProductModel {
    @Published var appleProductList = [ShoppingDTO]()
}

extension AppleProductModel {
    func fetchAppleProductResult() {
        let requests = AppleProductType.allCases.map { $0.request }
        var productList: [ShoppingDTO?] = Array(repeating: nil, count: AppleProductType.allCases.count)

        let group = DispatchGroup()
        
        for (idx, request) in requests.enumerated() {
            group.enter()
            DispatchQueue.global().async(group: group) {
                NetworkManager.requestAPI(req: request){ (result: ShoppingDTO) in
                    productList[idx] = result
                    group.leave()
                } failure: { _ in
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.appleProductList = productList.compactMap { $0 }
        }
    }
}
