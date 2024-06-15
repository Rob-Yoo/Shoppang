//
//  ProfileSettingContext.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import Foundation

enum ProfileSettingType {
    case New
    case Editing
    
    var navigationTitle: String {
        switch self {
        case .New:
            return "PROFILE SETTING"
        case .Editing:
            return "EDIT PROFILE"
        }
    }
}
