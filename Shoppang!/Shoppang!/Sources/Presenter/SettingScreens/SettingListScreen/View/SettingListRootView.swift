//
//  SettingListRootView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

final class SettingListRootView: UIView, RootViewProtocol {
    var navigationTitle: String = "SETTING"
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
