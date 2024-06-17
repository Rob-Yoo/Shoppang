//
//  SettingListRootView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import SnapKit
import Then

final class SettingListRootView: UIView, RootViewProtocol {
    var navigationTitle: String = "SETTING"
    
    let profileView = ProfileView()
    private let line = UIView().then { $0.backgroundColor = .black }
    let settingListTableView = SettingListTableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SettingListRootView {
    private func configureHierarchy() {
        self.addSubview(profileView)
        self.addSubview(line)
        self.addSubview(settingListTableView)
    }
    
    private func configureLayout() {
        profileView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(0.15)
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom)
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(0.4)
        }
        
        settingListTableView.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
