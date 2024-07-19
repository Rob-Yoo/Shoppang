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
    
    private let productImageView = ProductImageView(hasWishButton: false).then {
        $0.contentMode = .scaleAspectFit
        $0.imageView.layer.borderWidth = 0
    }
    
    private let productDetailStackView = ProductDetailStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellData(data: ProductDTO) {
        let url = URL(string: data.image)
        
        self.productImageView.imageView.kf.setImage(with: url)
        self.productDetailStackView.update(product: data)
    }
    
}

//MARK: - Configure Subviews
extension AppleProductCollectionViewCell {
    private func configureHierarchy() {
        self.contentView.addSubview(productImageView)
        self.contentView.addSubview(productDetailStackView)
    }
    
    private func configureLayout() {
        productImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(productImageView.snp.width)
        }
        
        productDetailStackView.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().offset(-5)
        }        
    }
}
