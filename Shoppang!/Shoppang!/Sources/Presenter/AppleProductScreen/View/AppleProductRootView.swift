//
//  AppleProductRootView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/26/24.
//

import UIKit
import SnapKit

final class AppleProductRootView: UIView, RootViewProtocol {
    var navigationTitle: String = Literal.NavigationTitle.AppleProduct
    
    let appleProductTableView = AppleProductTableView()
    
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
