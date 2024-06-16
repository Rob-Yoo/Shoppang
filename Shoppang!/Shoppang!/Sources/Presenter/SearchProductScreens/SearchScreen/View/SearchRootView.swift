//
//  SearchRootView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

final class SearchRootView: UIView, RootViewProtocol {
    var navigationTitle: String = "\(UserDefaults.standard.string(forKey: UserDefaultsKey.nickname)!)'s Shoppang!"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
