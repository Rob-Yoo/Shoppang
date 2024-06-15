//
//  InitialProfileSettingView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit
import SnapKit

final class InitialProfileSettingView: UIView, RootViewProtocol {
    let navigationTitle = ProfileSettingType.Initial.rawValue

    private let profileSettingView = ProfileSettingView(type: .Initial)
    
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
