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
    
    let addCartButton = UIButton().then {
        let unselectedImage = UIImage.likeUnselected
        let selectedImage = UIImage.likeSelected

        $0.setImage(unselectedImage, for: .normal)
        $0.setImage(selectedImage, for: .selected)
        $0.backgroundColor = UIColor(white: 0, alpha: 0.4)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductImageView {
    private func configureHierarchy() {
        self.addSubview(imageView)
        self.addSubview(addCartButton)
    }
    
    private func configureLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addCartButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalTo(addCartButton.snp.width)
        }
    }
}
