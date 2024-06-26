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

protocol ProductDetailViewDelegate: AnyObject {
    func handleURLError()
}

final class ProductDetailView: UIView {
    
    private let webView = WKWebView()
    var urlLink = "" {
        didSet {
            guard let url = URL(string: urlLink) else {
                guard let delegate = self.productDetailViewDelegate else { return }
                delegate.handleURLError()
                return
            }
            let request = URLRequest(url: url)
            
            webView.load(request)
        }
    }
    
    weak var productDetailViewDelegate: ProductDetailViewDelegate?
    
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
}

extension ProductDetailView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
        print(navigation.description)
        guard let delegate = self.productDetailViewDelegate else { return }
        delegate.handleURLError()
    }
}
