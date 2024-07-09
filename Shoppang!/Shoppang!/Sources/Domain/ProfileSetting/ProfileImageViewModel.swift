//
//  ProfileImageViewModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation
import UIKit.UIImage

final class ProfileImageViewModel {
    lazy var inputProfileImageNumber = loadProfileImageNumber()
    lazy var outputProfileImageNumber = Observable(inputProfileImageNumber.value)
    
    init() {
        inputProfileImageNumber.bind { [weak self] value in
            self?.outputProfileImageNumber.value = value
        }
    }
    
    private func loadProfileImageNumber() -> Observable<Int> {
        guard let imageNumber = UserDefaults.standard.string(forKey: UserDefaultsKey.profileImageNumber.rawValue) else {
            let randomNumber = Int.random(in: 0..<UIImage.profileImages.count)
            
            return Observable(randomNumber)
        }
        
        return Observable(Int(imageNumber)!)
    }
}
