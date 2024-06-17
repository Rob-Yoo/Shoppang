//
//  CartBarButton.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit

final class CartBarButton: UIButton {
    
    var isCart: Bool {
        didSet {
            self.configure()
        }
    }
    
    init(isCart: Bool) {
        self.isCart = isCart
        super.init(frame: .zero)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let image = isCart ? UIImage.likeSelected : UIImage.likeUnselected
        self.setImage(image, for: .normal)
    }
}
