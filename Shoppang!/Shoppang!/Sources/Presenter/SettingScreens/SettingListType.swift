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
    case oneToOneAsking
    case notificationSetting
    case deleteAccount
    
    var title: String {
        switch self {
        case .cartList:
            return "나의 장바구니 목록"
        case .faq:
            return "자주 묻는 질문"
        case .oneToOneAsking:
            return"1:1 문의"
        case .notificationSetting:
            return"알림 설정"
        case .deleteAccount:
            return "탈퇴하기"
        }
    }
}
