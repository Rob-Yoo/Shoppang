//
//  AppleProductTableViewCell.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit
import SnapKit
import Then

final class AppleProductTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .bold16
    }
    
    let productCollectionView = AppleProductCollectionView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppleProductTableViewCell {
    private func configureHierarchy() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(productCollectionView)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        productCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureCellData(title: String, productList: [Product]) {
        self.titleLabel.text = title
        self.productCollectionView.productList = productList
    }
}
