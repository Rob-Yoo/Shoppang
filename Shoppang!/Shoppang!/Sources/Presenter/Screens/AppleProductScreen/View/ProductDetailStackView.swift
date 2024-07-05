//
//  ProductDetailStackView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/26/24.
//

import UIKit
import Then

final class ProductDetailStackView: UIStackView {
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
    
    private var detailLabels: [UILabel] {
        return [mallNameLabel, productNameLabel, priceLabel]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 0
        self.detailLabels.forEach { self.addArrangedSubview($0) }
    }
    
    func update(product: Product) {
        let formattedPrice = Int(product.lprice)!.formatted()

        self.mallNameLabel.text = product.mallName
        self.productNameLabel.text = product.title.htmlElementDeleted
        self.priceLabel.text = formattedPrice + "원"
    }
}
