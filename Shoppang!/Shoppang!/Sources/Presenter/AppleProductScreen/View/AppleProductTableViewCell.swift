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
    
    private var productList = [Product]()
    
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
        self.productCollectionView.delegate = self
        self.productCollectionView.dataSource = self
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
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.productCollectionView.layoutIfNeeded()
    }
}

extension AppleProductTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = self.productList[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppleProductCollectionViewCell.reusableIdentifier, for: indexPath) as? AppleProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(data: data)
        return cell
    }
}
