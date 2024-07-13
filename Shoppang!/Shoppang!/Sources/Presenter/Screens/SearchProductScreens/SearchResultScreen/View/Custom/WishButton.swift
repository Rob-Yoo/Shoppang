//
//  WishButton.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit

final class WishButton: UIButton {
    
    var isWishList: Bool = false {
        didSet {
            let image: UIImage = isWishList ? .likeSelected : .likeUnselected
            let bgColor: UIColor = isWishList ? .white : UIColor(white: 0, alpha: 0.4)
            
            self.setImage(image, for: .normal)
            self.backgroundColor = bgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
