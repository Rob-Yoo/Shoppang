//
//  NicknameValidationStatus.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import Foundation

enum NicknameValidationStatus {
    case ok
    case countError
    case characterError
    case numberError
    case whitespaceError
    
    var statusText: String {
        switch self {
        case .ok:
            return Literal.StatusLabel.OK
        case .countError:
            return Literal.StatusLabel.CountError
        case .characterError:
            return Literal.StatusLabel.CharacterError
        case .numberError:
            return Literal.StatusLabel.NumError
        case .whitespaceError:
            return Literal.StatusLabel.WhitespaceError
        }
    }
}
