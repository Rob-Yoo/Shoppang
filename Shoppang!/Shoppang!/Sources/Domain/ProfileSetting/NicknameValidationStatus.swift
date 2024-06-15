//
//  NicknameValidationStatus.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import Foundation

enum NicknameValidationStatus {
    case ok
    case countError
    case characterError
    case numberError
    
    var statusText: String {
        switch self {
        case .ok:
            return "사용할 수 있는 닉네임입니다 :D"
        case .countError:
            return "2글자 이상 10글자 미만으로 설정해주세요."
        case .characterError:
            return "닉네임에 @, #, $, %, 띄어쓰기는 포함할 수 없어요."
        case .numberError:
            return "닉네임에 숫자는 포함할 수 없어요."
        }
    }
}
