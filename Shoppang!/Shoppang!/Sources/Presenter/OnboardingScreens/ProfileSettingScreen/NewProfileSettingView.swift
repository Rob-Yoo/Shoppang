//
//  InitialProfileSettingView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit
import SnapKit

final class NewProfileSettingView: UIView, RootViewProtocol {
    let navigationTitle = ProfileSettingType.New.rawValue

    let profileSettingView = ProfileSettingView(type: .New)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureProfileSettingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureProfileSettingView() {
        self.addSubview(profileSettingView)
        
        profileSettingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
