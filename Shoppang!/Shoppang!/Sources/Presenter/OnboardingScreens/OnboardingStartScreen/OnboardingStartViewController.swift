//
//  OnboardingStartViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import SnapKit
import Then

class OnboardingStartViewController: UIViewController {

    private let appTitleLabel = UILabel().then {
        $0.text = "Shoppang!"
        $0.textColor = .mainTheme
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 40, weight: .heavy)
    }
    
    private let appImageView = UIImageView().then {
        $0.image = .launch
        $0.contentMode = .scaleAspectFit
    }
    
    private let startButton = TextButton(type: .start)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.configureHierarchy()
        self.configureLayout()
    }
    
    private func configureHierarchy() {
        self.view.addSubview(appTitleLabel)
        self.view.addSubview(appImageView)
        self.view.addSubview(startButton)
    }
    
    private func configureLayout() {

        appImageView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.center.equalToSuperview()
        }
        
        appTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(appImageView.snp.top).inset(-100)
            $0.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
    }
}
