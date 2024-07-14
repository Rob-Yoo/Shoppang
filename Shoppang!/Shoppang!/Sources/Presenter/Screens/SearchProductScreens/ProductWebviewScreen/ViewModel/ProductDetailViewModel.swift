//
//  ProductDetailViewModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/14/24.
//

import Foundation

final class ProductDetailViewModel {

    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputWishButtonTapped: Observable<Void?> = Observable(nil)

    var outputProduct: Observable<ProductModel?> = Observable(nil)
    var outputIsWishList: Observable<Bool?> = Observable(nil)
    
    private var product: ProductModel
    private let repository = WishListRepository()

    init(product: ProductModel) {
        self.product = product
        self.transform()
    }
    
    private func transform() {
        self.inputViewDidLoadTrigger.bind { [weak self] signal in
            if (signal != nil), let self = self {
                self.outputProduct.value = self.product
            }
        }
        
        self.inputWishButtonTapped.bind { [weak self] signal in
            if (signal != nil) {
                self?.wishButtonTapped()
            }
        }
    }
    
    private func wishButtonTapped() {
        let isWishList = self.product.isWishList

        if (isWishList) {
            self.repository.deleteItem(productID: product.productId)
        } else {
            self.repository.createItem(product: product)
        }

        self.outputIsWishList.value = !isWishList
        self.product.isWishList.toggle()
    }
}
