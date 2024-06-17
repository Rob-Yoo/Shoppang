//
//  ProfileModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation
import Combine

protocol ProfileImageProtocol {
    var profileImageNumberPublisher: Published<Int>.Publisher { get }
    
    func setProfileImageNumber(number: Int)
}
