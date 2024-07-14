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
import Toast

final class ProductDetailView: UIView {
    
    private let webView = WKWebView()
    
    var handleURLError: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        webView.navigationDelegate = self
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
    
    func loadWebView(url: String) {
        guard let url = URL(string: url) else {
            handleURLError?()
            return
        }
        let request = URLRequest(url: url)
        
        self.makeToastActivity(.center)
        self.webView.load(request)
    }
}

extension ProductDetailView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
        handleURLError?()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideToastActivity()
    }
}
