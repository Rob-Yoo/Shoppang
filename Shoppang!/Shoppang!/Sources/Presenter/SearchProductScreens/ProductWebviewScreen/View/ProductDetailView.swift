//
//  ProductWebview.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit
import WebKit
import Then
import SnapKit

final class ProductDetailView: UIView {
    
    private let webView = WKWebView()
    var urlLink = "" {
        didSet {
            let url = URL(string: urlLink)!
            let request = URLRequest(url: url)
            
            webView.load(request)
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
        self.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
