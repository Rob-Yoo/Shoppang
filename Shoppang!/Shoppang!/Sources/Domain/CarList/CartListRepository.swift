//
//  CartListRepository.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import RealmSwift

final class CartListRepository {
    
    let realm = try! Realm()
    
    func createItem(data: CartProductDTO) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error)
        }
    }
    
    func fetchAll() -> Set<CartProductDTO> {
        return Set<CartProductDTO>(realm.objects(CartProductDTO.self))
    }
    
    func deleteItem(product: CartProductDTO) {
        do {
            try realm.write {
                guard let product = realm.object(ofType: CartProductDTO.self, forPrimaryKey: product.id) else { return }
                realm.delete(product)
            }
        } catch {
            print(error)
        }
    }
}
