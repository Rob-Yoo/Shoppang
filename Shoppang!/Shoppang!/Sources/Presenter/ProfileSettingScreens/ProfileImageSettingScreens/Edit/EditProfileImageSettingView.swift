//
//  EditProfileImageSettingView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit
import SnapKit

final class EditProfileImageSettingView: ProfileImageSettingView, RootViewProtocol {
    var navigationTitle = ProfileSettingType.Editing.navigationTitle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
