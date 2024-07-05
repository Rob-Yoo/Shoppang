//
//  CartListRootView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import UIKit

final class CartListRootView: UIView, RootViewProtocol {
    let navigationTitle = Literal.NavigationTitle.CartList
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
