//
//  ProductImageView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import SnapKit
import Then

final class ProductImageView: UIView {
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.placeholder.cgColor
        $0.layer.borderWidth = 0.5
    }
    
    lazy var cartButton = CartButton()
    
    init(hasCartButton: Bool = true) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.configureImageView()
        if (hasCartButton) {
            self.configureCarButton()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductImageView {

    private func configureImageView() {
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureCarButton() {
        self.addSubview(cartButton)
        
        cartButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalTo(cartButton.snp.width)
        }
    }
}
