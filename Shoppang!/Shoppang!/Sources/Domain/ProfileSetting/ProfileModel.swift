//
//  ProfileModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit
import Combine

class ProfileModel {
    @Published var nickname: String = ""
    var profileImage: UIImage = UIImage.profileImages.randomElement()!
    
    var nicknameValidationStatus: NicknameValidationStatus {
        if (isCountError()) { return .countError }
        if (isCharacterError()) { return .characterError }
        if (isNumberError()) { return .numberError }
        
        return .ok
    }
    
    func saveProfile() {
        if (nicknameValidationStatus == .ok) {
            UserDefaults.standard.setValue(profileImage, forKey: UserDefaultsKey.profileImage)
            UserDefaults.standard.setValue(nickname, forKey: UserDefaultsKey.nickname)
        }
    }
}

//MARK: - 닉네임 유효성 검사 로직
extension ProfileModel {
    private func isCountError() -> Bool {
        if (nickname.count < 2 || nickname.count >= 10) { return true }
        return false
    }
    
    private func isCharacterError() -> Bool {
        let forbiddenCharacters = ["@", "#", "$", "%", " "]
        let forbidden = nickname.filter { forbiddenCharacters.contains(String($0)) }
        
        return forbidden.isEmpty ? false : true
    }
    
    private func isNumberError() -> Bool {
        let forbidden = nickname.filter { $0.isNumber }
        
        return forbidden.isEmpty ? false : true
    }
}
