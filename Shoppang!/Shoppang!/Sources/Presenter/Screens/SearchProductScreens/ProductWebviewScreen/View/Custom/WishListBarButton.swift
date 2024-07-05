//
//  WishListBarButton.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit

final class WishListBarButton: UIButton {
    
    var isWishList: Bool {
        didSet {
            self.configure()
        }
    }
    
    init(isWishList: Bool) {
        self.isWishList = isWishList
        super.init(frame: .zero)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let image = isWishList ? UIImage.likeSelected : UIImage.likeUnselected
        self.setImage(image, for: .normal)
    }
}
