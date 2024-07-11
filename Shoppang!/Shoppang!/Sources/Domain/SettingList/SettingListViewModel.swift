//
//  SettingListViewModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/11/24.
//

import Foundation

final class SettingListViewModel {
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    var inputDeleteUserAccountButtonTapped: Observable<Void?> = Observable(nil)
    
    lazy var outputUserProfile: Observable<UserProfile> = Observable(repository.loadUserProfile())
    lazy var outputWishListCount = Observable(repository.loadWishListCount())
    var outputDeleteUserAccountTrigger: Observable<Void?> = Observable(nil)
    
    private let repository = SettingListRepository()

    init() {
        self.transform()
    }
    
    private func transform() {
        inputViewWillAppearTrigger.bind { [weak self] _ in
            self?.loadUserProfile()
            self?.loadWishListCount()
        }
        
        inputDeleteUserAccountButtonTapped.bind { [weak self] signal in
            if (signal != nil) {
                self?.repository.deleteUserAccount()
                self?.outputDeleteUserAccountTrigger.value = ()
            }
        }
    }
}

extension SettingListViewModel {
    private func loadUserProfile() {
        let userProfile = repository.loadUserProfile()
        self.outputUserProfile.value = userProfile
    }
    
    private func loadWishListCount() {
        let wishListCount = repository.loadWishListCount()
        self.outputWishListCount.value = wishListCount
    }
}
