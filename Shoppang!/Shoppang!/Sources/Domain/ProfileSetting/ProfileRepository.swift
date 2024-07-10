//
//  ProfileRepository.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/11/24.
//

import Foundation
import UIKit.UIImage

final class ProfileRepository {
    func loadNickname() -> Observable<String> {
        guard let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) else {
            return Observable("")
        }
        
        return Observable(nickname)
    }
    
    func loadProfileImageNumber() -> Observable<Int> {
        guard let imageNumber = UserDefaults.standard.string(forKey: UserDefaultsKey.profileImageNumber.rawValue) else {
            let randomNumber = Int.random(in: 0..<UIImage.profileImages.count)
            
            return Observable(randomNumber)
        }
        
        return Observable(Int(imageNumber)!)
    }
    
    func saveUserProfile(nickname: String, profileImageNumber: Int) {
        self.saveJoinInfo()

        UserDefaults.standard.setValue(profileImageNumber, forKey: UserDefaultsKey.profileImageNumber.rawValue)
        UserDefaults.standard.setValue(nickname, forKey: UserDefaultsKey.nickname.rawValue)
    }
}

extension ProfileRepository {
    private func saveJoinInfo() {
        let isUser = UserDefaults.standard.bool(forKey: UserDefaultsKey.isUser.rawValue)

        if (isUser == false) {
            UserDefaults.standard.setValue(true, forKey: UserDefaultsKey.isUser.rawValue)
            self.saveJoinDate()
        }
    }
    
    private func saveJoinDate() {
        let currentDate = String.getCurrentDate(dateFormat: "yyyy.MM.dd")

        UserDefaults.standard.setValue(currentDate, forKey: UserDefaultsKey.joinDate.rawValue)
    }
}
