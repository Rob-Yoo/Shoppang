//
//  NewProfileImageSettingView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit
import SnapKit

final class NewProfileImageSettingView: ProfileImageSettingView, RootViewProtocol {
    var navigationTitle = ProfileSettingType.New.navigationTitle
    
//    private let profileImageSettingView = ProfileImageSettingView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
