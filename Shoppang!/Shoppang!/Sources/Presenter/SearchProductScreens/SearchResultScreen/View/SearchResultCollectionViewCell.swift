//
//  SearchResultCollectionViewCell.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class SearchResultCollectionViewCell: UICollectionViewCell {
    
    let productImageView = ProductImageView()
    
    private let mallNameLabel = UILabel().then {
        $0.textColor = .placeholder
        $0.font = .regular13
    }
    
    private let productNameLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.font = .medium14
    }
    
    private let priceLabel = UILabel().then {
        $0.textColor = .black
        $0.font  = .bold14
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellData(data: SearchResult) {
        let url = URL(string: data.image)
        let formattedPrice = Int(data.lprice)!.formatted()

        self.productImageView.imageView.kf.setImage(with: url)
        self.mallNameLabel.text = data.mallName
        self.productNameLabel.text = data.title.htmlElementDeleted
        self.priceLabel.text = formattedPrice + "원"
    }
}

//MARK: - Configure Subviews
extension SearchResultCollectionViewCell {
    private func configureHierarchy() {
        self.addSubview(productImageView)
        self.addSubview(mallNameLabel)
        self.addSubview(productNameLabel)
        self.addSubview(priceLabel)
    }
    
    private func configureLayout() {
        productImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
        }
        
        mallNameLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(mallNameLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
        }
    }
}
