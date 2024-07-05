//
//  SettingListType.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation

enum SettingListType: CaseIterable {
    case wishList
    case faq
    case privateAsking
    case notificationSetting
    case deleteAccount
    
    var title: String {
        switch self {
        case .wishList:
            return Literal.SettingList.WishList
        case .faq:
            return Literal.SettingList.FAQ
        case .privateAsking:
            return Literal.SettingList.PrivateAsking
        case .notificationSetting:
            return Literal.SettingList.NotificationSetting
        case .deleteAccount:
            return Literal.SettingList.DeleteAccount
        }
    }
}
