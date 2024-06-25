//
//  AppleProductCollectionViewCell.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit
import SnapKit
import Kingfisher
import Then

final class AppleProductCollectionViewCell: UICollectionViewCell {
    
    lazy var productImageView = ProductImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.imageView.layer.borderWidth = 0
    }
    
    private let mallNameLabel = UILabel().then {
        $0.textColor = .placeholder
        $0.font = .regular13
    }
    
    private let productNameLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.font = .medium13
    }
    
    private let priceLabel = UILabel().then {
        $0.textColor = .black
        $0.font  = .bold13
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellData(data: Product) {
        let url = URL(string: data.image)
        let formattedPrice = Int(data.lprice)!.formatted()

        self.productImageView.imageView.kf.setImage(with: url)
        self.mallNameLabel.text = data.mallName
        self.productNameLabel.text = data.title.htmlElementDeleted
        self.priceLabel.text = formattedPrice + "원"
    }
}

//MARK: - Configure Subviews
extension AppleProductCollectionViewCell {
    private func configureHierarchy() {
        self.addSubview(productImageView)
        self.addSubview(mallNameLabel)
        self.addSubview(productNameLabel)
        self.addSubview(priceLabel)
    }
    
    private func configureLayout() {
        productImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(productImageView.snp.width)
        }
        
        mallNameLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(3)
            $0.leading.equalToSuperview().offset(5)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(mallNameLabel.snp.bottom).offset(3)
            $0.horizontalEdges.equalToSuperview().inset(5)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(3)
            $0.leading.equalToSuperview().inset(5)
        }
    }
}
