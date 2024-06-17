//
//  ProfileModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit
import Combine

final class ProfileModel {
    @Published var nickname: String = {
        
        guard let userNickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname) else {
            return ""
        }
        
        return userNickname
    }()

    @Published var profileImageNumber: Int = {

        guard let imageNumber = UserDefaults.standard.string(forKey: UserDefaultsKey.profileImageNumber) else {
            return Int.random(in: 0..<UIImage.profileImages.count)
        }
        
        return Int(imageNumber)!
    }()
    
    var nicknameValidationStatus: NicknameValidationStatus {
        if (isCountError()) { return .countError }
        if (isCharacterError()) { return .characterError }
        if (isNumberError()) { return .numberError }
        
        return .ok
    }
    
    func saveProfile() {
        guard (nicknameValidationStatus == .ok) else { return }
        let isUser = UserDefaults.standard.bool(forKey: UserDefaultsKey.isUser)

        if (isUser == false) {
            UserDefaults.standard.setValue(true, forKey: UserDefaultsKey.isUser)
            self.saveJoinDate()
        }

        self.saveUserProfile()
    }
    
    private func saveJoinDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let currentDate = dateFormatter.string(from: Date())

        UserDefaults.standard.setValue(currentDate, forKey: UserDefaultsKey.joinDate)
    }
    
    private func saveUserProfile() {
        UserDefaults.standard.setValue(String(profileImageNumber), forKey: UserDefaultsKey.profileImageNumber)
        UserDefaults.standard.setValue(nickname, forKey: UserDefaultsKey.nickname)
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
