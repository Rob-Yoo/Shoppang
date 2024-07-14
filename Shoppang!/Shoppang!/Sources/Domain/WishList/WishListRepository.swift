//
//  WishListRepository.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import RealmSwift
import Foundation
import Combine

final class WishListRepository {
    
    private let realm = try! Realm()
    private var list: Results<WishProduct>
    private var cancellable = Set<AnyCancellable>()

    init() {
        self.list = realm.objects(WishProduct.self)
        self.saveWishListCount()
    }
    
    private func saveWishListCount() {
        self.list.objectWillChange
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let list = self?.list else { return }
                UserDefaults.standard.setValue(list.count, forKey: UserDefaultsKey.userWishListCount.rawValue)
            }
            .store(in: &cancellable)
    }
    
    func createItem(product: ProductModel) {
        do {
            try realm.write {
                realm.add(WishProduct(product: product))
            }
        } catch {
            print(error)
        }
    }
    
    func fetchAllProductModel() -> [ProductModel] {
        return list.map { ProductModel.createProductModel($0) }.reversed()
    }
    
    func fetchAllProduct() -> [Product] {
        return list.map{ Product(title: $0.title, link: $0.link, image: $0.image, lprice: $0.lprice, mallName: $0.mallName, productId: $0.productId) }
    }
    
    func deleteItem(productID: String) {
        guard let deleteProduct = self.list.first(where: {
            $0.productId == productID
        }) else { return }
        
        do {
            try realm.write {
                realm.delete(deleteProduct)
            }
        } catch {
            print(error)
        }
    }
}
