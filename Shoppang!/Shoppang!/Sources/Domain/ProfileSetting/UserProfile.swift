//
//  UserProfile.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation

struct UserProfile {
    let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname) ?? "옹골찬 고래밥"
    let profileImageNumber = UserDefaults.standard.integer(forKey: UserDefaultsKey.profileImageNumber)
    let cartListCount = {
        guard let cartList = UserDefaults.standard.array(forKey: UserDefaultsKey.userCartList) as? [String] else { return 0 }
        
        return cartList.count
    }()
}
