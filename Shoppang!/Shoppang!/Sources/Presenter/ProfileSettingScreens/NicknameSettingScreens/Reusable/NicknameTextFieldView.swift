//
//  NicknameTextFieldView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit
import SnapKit
import Then

final class NicknameTextFieldView: UIView {
    
    let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요 :)"
        $0.font = .regular14
        $0.textColor = .black
        $0.borderStyle = .none
    }
    
    private let line = UIView().then {
        $0.backgroundColor = .placeholder
    }
    
    let statusLabel = UILabel().then {
        $0.textColor = .mainTheme
        $0.font = .regular13
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(status: NicknameValidationStatus) {
        let statusColor: UIColor = (status == .ok) ? .black : .mainTheme
        let lineColor: UIColor = (status == .ok) ? .black : .placeholder

        self.line.backgroundColor = lineColor
        self.statusLabel.text = status.statusText
        self.statusLabel.textColor = statusColor
    }
    
}

extension NicknameTextFieldView {
    private func configureHierarchy() {
        self.addSubview(nicknameTextField)
        self.addSubview(line)
        self.addSubview(statusLabel)
    }
    
    private func configureLayout() {
        nicknameTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(line).offset(3)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
