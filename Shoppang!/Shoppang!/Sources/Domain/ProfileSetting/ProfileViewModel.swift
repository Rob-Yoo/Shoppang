//
//  ProfileViewModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation

final class ProfileViewModel {
    lazy var inputNickname = self.loadNickname()
    var inputSaveButtonTapped: Observable<Void?> = Observable(nil)
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    
    var outputNicknameValidationStatus: Observable<NicknameValidationStatus> = Observable(.countError)
    var outputValidation = Observable(false)
    lazy var outputProfileImageNumber = Observable(profileImageViewModel.outputProfileImageNumber.value)
    
    var profileImageViewModel = ProfileImageViewModel()

    init() {
        inputNickname.bind { [weak self] _ in
            self?.checkNicknameValidationStatus()
        }
        
        inputSaveButtonTapped.bind { [weak self] value in
            if value != nil {
                self?.saveProfile()
            }
        }
        
        inputViewWillAppearTrigger.bind { [weak self] _ in
            guard let viewModel = self else { return }
            
            viewModel.outputProfileImageNumber.value = viewModel.profileImageViewModel.outputProfileImageNumber.value
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

        self.saveJoinInfo()
        self.saveUserProfile()
        self.outputValidation.value = true
    }
}

//MARK: - Load User Data From UserDefaults
extension ProfileViewModel {
    private func loadNickname() -> Observable<String> {
        guard let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) else {
            return Observable("")
        }
        
        return Observable(nickname)
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

//MARK: - Save User Profile Logic
extension ProfileViewModel {
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
    
    private func saveUserProfile() {
        let profileImageNumber = self.profileImageViewModel.outputProfileImageNumber.value
        let nickname = inputNickname.value
        
        UserDefaults.standard.setValue(profileImageNumber, forKey: UserDefaultsKey.profileImageNumber.rawValue)
        UserDefaults.standard.setValue(nickname, forKey: UserDefaultsKey.nickname.rawValue)
    }
}
