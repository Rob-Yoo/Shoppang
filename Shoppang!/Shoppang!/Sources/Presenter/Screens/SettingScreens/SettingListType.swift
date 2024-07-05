//
//  SettingListType.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation

enum SettingListType: CaseIterable {
    case cartList
    case faq
    case privateAsking
    case notificationSetting
    case deleteAccount
    
    var title: String {
        switch self {
        case .cartList:
            return Literal.SettingList.CartList
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
