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
        
        guard let userNickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) else {
            return ""
        }
        
        return userNickname
    }()

    @Published var profileImageNumber: Int = {

        guard let imageNumber = UserDefaults.standard.string(forKey: UserDefaultsKey.profileImageNumber.rawValue) else {
            return Int.random(in: 0..<UIImage.profileImages.count)
        }
        
        return Int(imageNumber)!
    }()
    
    func checkNicknameValidationStatus() -> NicknameValidationStatus {
        return self.validateNickname(nickname: nickname)
    }
    
    func saveProfile() {
        guard (checkNicknameValidationStatus() == .ok) else { return }
        let isUser = UserDefaults.standard.bool(forKey: UserDefaultsKey.isUser.rawValue)

        if (isUser == false) {
            UserDefaults.standard.setValue(true, forKey: UserDefaultsKey.isUser.rawValue)
            self.saveJoinDate()
        }

        self.saveUserProfile()
    }

}

//MARK: - Implementation ProfileImageModel
extension ProfileModel: ProfileImageProtocol {
    var profileImageNumberPublisher: Published<Int>.Publisher { return $profileImageNumber }
    
    func setProfileImageNumber(number: Int) {
        self.profileImageNumber = number
    }
}

//MARK: - 닉네임 유효성 검사 로직
extension ProfileModel {
    func validateNickname(nickname: String) -> NicknameValidationStatus {
        if (isCountError(nickname)) { return .countError }
        if (isCharacterError(nickname)) { return .characterError }
        if (isNumberError(nickname)) { return .numberError }
        if (isWhitespaceError(nickname)) { return .whitespaceError }
        
        return .ok
    }

    private func isCountError(_ nickname: String) -> Bool {
        if (nickname.count < 2 || nickname.count >= 10) { return true }
        return false
    }
    
    private func isCharacterError(_ nickname: String) -> Bool {
        let forbiddenCharacters = ["@", "#", "$", "%"]
        let forbidden = nickname.filter { forbiddenCharacters.contains(String($0)) }
        
        return forbidden.isEmpty ? false : true
    }
    
    private func isNumberError(_ nickname: String) -> Bool {
        let forbidden = nickname.filter { $0.isNumber }
        
        return forbidden.isEmpty ? false : true
    }
    
    private func isWhitespaceError(_ nickname: String) -> Bool {
        let filteredWhitespace = nickname.trimmingCharacters(in: .whitespaces)
        
        guard nickname == filteredWhitespace else { return true }
        guard nickname.filter({ $0.isWhitespace }).count <= 1 else { return true }
        
        return false
    }
}

//MARK: - Save Data Methods
extension ProfileModel {
    private func saveJoinDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let currentDate = dateFormatter.string(from: Date())

        UserDefaults.standard.setValue(currentDate, forKey: UserDefaultsKey.joinDate.rawValue)
    }
    
    private func saveUserProfile() {
        UserDefaults.standard.setValue(String(profileImageNumber), forKey: UserDefaultsKey.profileImageNumber.rawValue)
        UserDefaults.standard.setValue(nickname, forKey: UserDefaultsKey.nickname.rawValue)
    }
}
