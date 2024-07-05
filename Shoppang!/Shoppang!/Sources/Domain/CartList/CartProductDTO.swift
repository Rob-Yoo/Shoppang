//
//  CartProduct.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import RealmSwift

final class CartProductDTO: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var image: String
    @Persisted var lprice: String
    @Persisted var mallName: String
    @Persisted var productId: String
    
    convenience init(product: Product) {
        self.init()
        self.title = product.title
        self.link = product.link
        self.image = product.image
        self.lprice = product.lprice
        self.mallName = product.mallName
        self.productId = product.productId
    }
}
