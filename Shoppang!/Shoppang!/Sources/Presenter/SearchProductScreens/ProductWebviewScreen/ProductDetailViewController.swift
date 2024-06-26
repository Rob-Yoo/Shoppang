//
//  ProductWebViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit
import Toast

protocol ProductDetailViewControllerDelegate: AnyObject {
    func showInvalidUrlToast()
}

final class ProductDetailViewController: BaseViewController<ProductDetailView> {

    private var model: CartProtocol
    private var product: Product
    private var isCart: Bool
    
    weak var productDetailViewControllerDelegate: ProductDetailViewControllerDelegate?
    
    init(product: Product, model: CartProtocol, isCart: Bool) {
        self.model = model
        self.product = product
        self.isCart = isCart
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.contentView.productDetailViewDelegate = self
        self.contentView.urlLink = product.link
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = product.title.htmlElementDeleted
        let button = CartBarButton(isCart: self.isCart)
        let barbutton = UIBarButtonItem(customView: button)
        
        self.navigationItem.rightBarButtonItem = barbutton
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
    }
    
    @objc private func cartButtonTapped(sender: UIButton) {
        guard let cartButton = sender as? CartBarButton else { return }
        cartButton.isCart ? self.model.removeFromCartList(productID: product.productId) : self.model.addToCartList(productID: product.productId)
        cartButton.isCart.toggle()
    }
}

extension ProductDetailViewController: ProductDetailViewDelegate {
    func handleURLError() {
        guard let delegate = self.productDetailViewControllerDelegate else {
            print("ProductDetailViewControllerDelegate 설정 후 사용해주세요")
            return
        }
        
        self.navigationController?.popViewController(animated: true)
        delegate.showInvalidUrlToast()
    }
}
