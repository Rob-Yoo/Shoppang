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

protocol ProductCollectionViewCellDelegate: AnyObject {
    func cartButtonTapped(idx: Int)
}

final class ProductCollectionViewCell: UICollectionViewCell {
    
    lazy var productImageView = ProductImageView().then {
        $0.cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
    }
    
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
    
    func configureCellData(data: Product, isCart: Bool) {
        let url = URL(string: data.image)
        let formattedPrice = Int(data.lprice)!.formatted()

        self.productImageView.imageView.kf.setImage(with: url)
        self.mallNameLabel.text = data.mallName
        self.productNameLabel.text = data.title.htmlElementDeleted
        self.priceLabel.text = formattedPrice + "원"
        self.productImageView.cartButton.isCart = isCart
    }
    
    @objc func cartButtonTapped() {
        guard let collectionView = superview as? UICollectionView, let indexPath = collectionView.indexPath(for: self) else { return }

        guard let delegate = collectionView.delegate as? ProductCollectionViewCellDelegate else {
            print("ProductCollectionViewCellDelegate를 채택하지 않았습니다")
            return
        }
        
        delegate.cartButtonTapped(idx: indexPath.item)
    }
}

//MARK: - Configure Subviews
extension ProductCollectionViewCell {
    private func configureHierarchy() {
        self.addSubview(productImageView)
        self.addSubview(mallNameLabel)
        self.addSubview(productNameLabel)
        self.addSubview(priceLabel)
    }
    
    private func configureLayout() {
        productImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.6)
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
