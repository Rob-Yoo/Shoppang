//
//  EditProfileModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation
import Combine

final class EditProfileModel {

    private let profileModel: ProfileModel
    
    @Published var nickname: String
    @Published var profileImageNumber: Int

    init() {
        self.profileModel = ProfileModel()
        self.nickname = profileModel.nickname
        self.profileImageNumber = profileModel.profileImageNumber
    }
    
    func checkNicknameValidationStatus() -> NicknameValidationStatus {
        return self.profileModel.validateNickname(nickname: nickname)
    }
    
    func saveProfile() {
        self.profileModel.nickname = nickname
        self.profileModel.profileImageNumber = profileImageNumber
        self.profileModel.saveProfile()
    }
}

//MARK: - Implementation ProfileImageModel
extension EditProfileModel: ProfileImageProtocol {
    var profileImageNumberPublisher: Published<Int>.Publisher { return $profileImageNumber }
    
    func setProfileImageNumber(number: Int) {
        self.profileImageNumber = number
    }
}
