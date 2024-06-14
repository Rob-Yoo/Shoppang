//
//  SearchRootView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

final class SearchRootView: UIView, NavigationBarTitleProtocol {
    //TODO: - UserDefault로부터 유저 닉네임 받아오기
    var navigationTitle: String = "${username}'s Shoppang"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
