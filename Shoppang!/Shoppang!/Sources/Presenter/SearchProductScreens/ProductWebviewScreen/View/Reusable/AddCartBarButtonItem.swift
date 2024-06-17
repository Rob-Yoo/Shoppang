//
//  AddCartBarButtonItem.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit

final class AddCartBarButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            let image = isSelected ? UIImage.likeSelected : UIImage.likeUnselected
            self.setImage(image, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.setImage(.likeSelected, for: .normal)
    }
}
