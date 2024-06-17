//
//  ProductWebViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit

final class ProductDetailViewController: BaseViewController<ProductDetailView> {

    private let navigationTitle: String
    private let weblink: String
    
    init(product: Product) {
        self.navigationTitle = product.title.htmlElementDeleted
        self.weblink = product.link
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.contentView.urlLink = weblink
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = self.navigationTitle
        let button = AddCartBarButton()
        let barbutton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barbutton
        button.addTarget(self, action: #selector(addCartButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addCartButtonTapped(sender: UIButton) {
        guard let addCartButton = sender as? AddCartBarButton else { return }
        
        addCartButton.isSelected.toggle()
    }
}
