//
//  WishListRepository.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import RealmSwift

final class WishListRepository {
    
    private let realm = try! Realm()
    private var list: Results<WishProductDTO>
    
    init() {
        self.list = realm.objects(WishProductDTO.self)
    }
    
    func createItem(product: Product) {
        do {
            try realm.write {
                realm.add(WishProductDTO(product: product))
            }
        } catch {
            print(error)
        }
    }
    
    func fetchAll() -> [Product] {
        return list.map { Product.createProduct(dto: $0) }.reversed()
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