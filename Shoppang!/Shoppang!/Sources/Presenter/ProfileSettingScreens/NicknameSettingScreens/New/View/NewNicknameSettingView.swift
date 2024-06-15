//
//  NewNicknameSettingView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit
import SnapKit

final class NewNicknameSettingView: UIView, RootViewProtocol {
    let navigationTitle = ProfileSettingType.New.navigationTitle

    let nicknameSettingView = NicknameSettingView(type: .New)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNicknameSettingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureNicknameSettingView() {
        self.addSubview(nicknameSettingView)
        
        nicknameSettingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
