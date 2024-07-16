//
//  WishListViewModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import Foundation

final class WishListViewModel {
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var inputWishButtonTapped: Observable<Int?> = Observable(nil)
    var inputWishListSortType: Observable<WishListSortType> = Observable(.add)
    var inputViewWillDisappearTrigger: Observable<Void?> = Observable(nil)
    
    var outputWishList: Observable<[ProductModel]> = Observable([])
    lazy var outputWishListSortType: Observable<WishListSortType> = Observable(inputWishListSortType.value)
    
    private var willDeleteWishList = [ProductModel]()
    private var repository = WishListRepository()

    init() {
        self.transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bind { [weak self] signal in
            if (signal != nil) {
                self?.loadWishList()
            }
        }
        
        inputWishButtonTapped.bind { [weak self] idx in
            guard let idx = idx else { return }
            self?.wishButtonTapped(idx: idx)
        }
        
        inputWishListSortType.bind { [weak self] type in
            self?.loadWishList()
            self?.outputWishListSortType.value = type
        }
        
        inputViewWillDisappearTrigger.bind { [weak self] _ in
            self?.removePendingWishList()
        }
    }
    
    private func loadWishList() {
        let wishList = repository.fetchAllProductModel()

        switch inputWishListSortType.value {
        case .add:
            self.outputWishList.value = wishList
        case .asc:
            self.outputWishList.value = wishList.sorted { Int($0.lprice)! < Int($1.lprice)! }
        case .dsc:
            self.outputWishList.value = wishList.sorted { Int($0.lprice)! > Int($1.lprice)! }
        case .mallName:
            self.outputWishList.value = wishList.sorted { $0.mallName < $1.mallName }
        }
    }
    
    private func wishButtonTapped(idx: Int) {
        let product = self.outputWishList.value[idx]
        let isWishList = !self.isWillDeleteWishList(product: product)

        if (isWishList) {
            // 위시 리스트라면 찜 목록 삭제 버퍼에 저장
            self.addToWillDeleteWishList(product: product, idx: idx)
        } else {
            // 아니라면 찜 목록 삭제 버퍼에서 제거
            self.removeToWillDeleteWishList(product: product, idx: idx)
        }
    }
}

//MARK: - Add/Delete Pending
extension WishListViewModel {
    private func isWillDeleteWishList(product: ProductModel) -> Bool {
        return self.willDeleteWishList.contains { $0.productId == product.productId }
    }
    
    private func addToWillDeleteWishList(product: ProductModel, idx: Int) {
        self.willDeleteWishList.append(product)
        self.outputWishList.value[idx].isWishList.toggle()
    }
    
    private func removeToWillDeleteWishList(product: ProductModel, idx: Int) {
        self.willDeleteWishList = willDeleteWishList.filter { $0.productId != product.productId }
        self.outputWishList.value[idx].isWishList.toggle()
    }
    
    private func removePendingWishList() {
        self.willDeleteWishList.forEach { self.repository.deleteItem(productID: $0.productId) }
        self.willDeleteWishList.removeAll()
    }
}
