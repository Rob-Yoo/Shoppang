//
//  Literal.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/18/24.
//

import Foundation

enum Literal {
    enum NavigationTitle {
        static let NewProfile = "PROFILE SETTING"
        static let Search = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? "옹골찬 고래밥" + "'s Shoppang!"
        static let Setting = "SETTING"
        static let EditProfile = "EDIT PROFILE"
    }
    
    enum Placeholder {
        static let Nickname = "닉네임을 입력해주세요 :)"
        static let Search = "브랜드, 상품 등을 입력하세요."
    }
    
    enum StatusLabel {
        static let OK = "사용 가능한 닉네임입니다 :D"
        static let CountError = "2글자 이상 10글자 미만으로 설정해주세요"
        static let CharacterError = "닉네임에 @, #, $, % 는 포함할 수 없어요."
        static let NumError = "닉네임에 숫자는 포함할 수 없어요."
    }
    
    enum SettingList {
        static let CartList = "나의 장바구니 목록"
        static let FAQ = "자주 묻는 질문"
        static let PrivateAsking = "1:1 문의"
        static let NotificationSetting = "알림 설정"
        static let DeleteAccount = "탈퇴하기"
    }
    
    enum ButtonTitle {
        static let Start = "시작하기"
        static let Complete = "완료"
        static let Save = "저장"
        static let DeleteAll = "전체 삭제"
        static let Sim = "정확도"
        static let Date = "날짜순"
        static let Dsc = "가격높은순"
        static let Asc = "가격낮은순"
    }
}
