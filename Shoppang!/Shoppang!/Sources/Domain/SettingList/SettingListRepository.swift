//
//  SettingListRepository.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/11/24.
//

import Foundation
import RealmSwift

final class SettingListRepository {
    
    private let realm = try! Realm()
    
    func loadUserProfile() -> UserProfileModel {
        let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? "옹골찬 고래밥"
        let profileImageNumber = UserDefaults.standard.integer(forKey: UserDefaultsKey.profileImageNumber.rawValue)
        let userJoinDate = UserDefaults.standard.string(forKey: UserDefaultsKey.joinDate.rawValue) ?? "0000.00.00"
        
        return UserProfileModel(nickname: nickname, profileImageNumber: profileImageNumber, userJoinDate: userJoinDate)
    }
    
    func loadWishListCount() -> Int {
        let wishListCount = UserDefaults.standard.integer(forKey: UserDefaultsKey.userWishListCount.rawValue)
        
        return wishListCount
    }
    
    func deleteUserAccount() {
        UserDefaultsKey.allCases.forEach {
            UserDefaults.standard.removeObject(forKey: $0.rawValue)
        }
        
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
}
