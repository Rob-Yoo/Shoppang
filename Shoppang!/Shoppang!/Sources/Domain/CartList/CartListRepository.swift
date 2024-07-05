//
//  CartListRepository.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import RealmSwift

final class CartListRepository {
    
    private let realm = try! Realm()
    private var list: Results<CartProductDTO>
    
    init() {
        self.list = realm.objects(CartProductDTO.self)
    }
    
    func createItem(product: Product) {
        do {
            try realm.write {
                realm.add(CartProductDTO(product: product))
            }
        } catch {
            print(error)
        }
    }
    
    func fetchAll() -> [Product] {
        return list.map { Product.createProduct(dto: $0) }
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
