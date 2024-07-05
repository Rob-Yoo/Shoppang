//
//  AppleProductRootView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/26/24.
//

import UIKit
import SnapKit
import Then

final class AppleProductRootView: UIView, RootViewProtocol {
    var navigationTitle: String = Literal.NavigationTitle.AppleProduct
    
    let appleProductTableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .clear
        $0.rowHeight = UIScreen.main.bounds.height * 0.3
        $0.showsVerticalScrollIndicator = false
        $0.allowsSelection = false
        $0.separatorStyle = .none
        $0.register(AppleProductTableViewCell.self, forCellReuseIdentifier: AppleProductTableViewCell.reusableIdentifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(appleProductTableView)
        
        appleProductTableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
