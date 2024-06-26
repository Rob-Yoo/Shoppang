//
//  AppleProductView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit
import SnapKit

final class AppleProductTableView: UITableView {
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.backgroundColor = .clear
        self.rowHeight = UIScreen.main.bounds.height * 0.3
        self.showsVerticalScrollIndicator = false
        self.allowsSelection = false
        self.separatorStyle = .none
        self.register(AppleProductTableViewCell.self, forCellReuseIdentifier: AppleProductTableViewCell.reusableIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
