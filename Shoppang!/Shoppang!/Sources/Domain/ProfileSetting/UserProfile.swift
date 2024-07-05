//
//  UserProfile.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation

struct UserProfile {
    let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? "옹골찬 고래밥"
    let profileImageNumber = UserDefaults.standard.integer(forKey: UserDefaultsKey.profileImageNumber.rawValue)
    let userJoinDate = UserDefaults.standard.string(forKey: UserDefaultsKey.joinDate.rawValue) ?? "0000.00.00"
    let wishListCount = UserDefaults.standard.integer(forKey: UserDefaultsKey.userWishListCount.rawValue)
}
