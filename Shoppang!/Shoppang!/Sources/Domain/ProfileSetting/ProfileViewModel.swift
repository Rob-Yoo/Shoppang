//
//  ProfileViewModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation

final class ProfileViewModel {
    lazy var inputNickname = repository.loadNickname()
    lazy var inputProfileImageNumber = repository.loadProfileImageNumber()
    var inputSaveButtonTapped: Observable<Void?> = Observable(nil)
    
    var outputNicknameValidationStatus: Observable<NicknameValidationStatus> = Observable(.countError)
    var outputValidation = Observable(false)
    lazy var outputProfileImageNumber = Observable(inputProfileImageNumber.value)

    private let repository = ProfileRepository()
    
    init() {
        self.transfrom()
    }
    
    private func transfrom() {
        self.inputNickname.bind { [weak self] _ in
            self?.checkNicknameValidationStatus()
        }
        
        self.inputProfileImageNumber.bind { [weak self] imageNumber in
            self?.changeProfileImage(imageNumber: imageNumber)
        }
        
        self.inputSaveButtonTapped.bind { [weak self] value in
            if value != nil {
                self?.saveProfile()
            }
        }
    }
    
    private func checkNicknameValidationStatus() {
        self.outputNicknameValidationStatus.value = validateNickname(nickname: inputNickname.value)
    }
    
    private func saveProfile() {
        guard (outputNicknameValidationStatus.value == .ok) else {
            self.outputValidation.value = false
            return
        }
        
        let nickname = self.inputNickname.value
        let profileImageNumber = self.inputProfileImageNumber.value
        
        self.repository.saveUserProfile(nickname: nickname, profileImageNumber: profileImageNumber)
        self.outputValidation.value = true
    }
    
    private func changeProfileImage(imageNumber: Int) {
        self.outputProfileImageNumber.value = imageNumber
    }
}

//MARK: - 닉네임 유효성 검사 로직
extension ProfileViewModel {
    private func validateNickname(nickname: String) -> NicknameValidationStatus {
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
