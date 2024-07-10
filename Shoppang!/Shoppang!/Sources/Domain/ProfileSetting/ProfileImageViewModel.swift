//
//  ProfileImageViewModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation

final class ProfileImageViewModel {
    var inputProfileImageNumber: Observable<Int>
    lazy var outputProfileImageNumber = Observable(inputProfileImageNumber.value)
    
    init(imageNumber: Int) {
        self.inputProfileImageNumber = Observable(imageNumber)

        inputProfileImageNumber.bind { [weak self] value in
            self?.outputProfileImageNumber.value = value
        }
    }
}
