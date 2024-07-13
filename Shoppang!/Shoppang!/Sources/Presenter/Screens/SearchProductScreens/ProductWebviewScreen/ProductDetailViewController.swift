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

//    private let model: WishListModel
//    private let product: Product
    
//    weak var productDetailViewControllerDelegate: ProductDetailViewControllerDelegate?
//    
//    init(product: Product, model: WishListModel) {
//        self.model = model
//        self.product = product
//        super.init()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.configureNavigationBar()
//        self.contentView.productDetailViewDelegate = self
//        self.contentView.urlLink = product.link
//    }
    
//    private func configureNavigationBar() {
//        let isWishList = self.model.isWishList(productID: product.productId)
//        let button = WishListBarButton(isWishList: isWishList)
//        let barbutton = UIBarButtonItem(customView: button)
//        
//        self.navigationItem.title = product.title.htmlElementDeleted
//        self.navigationItem.rightBarButtonItem = barbutton
//        button.addTarget(self, action: #selector(wishButtonTapped), for: .touchUpInside)
//    }
    
//    @objc private func wishButtonTapped(sender: UIButton) {
//        guard let wishButton = sender as? WishListBarButton else { return }
//        wishButton.isWishList ? self.model.removeFromWishList(productID: product.productId) : self.model.addToWishList(product: product)
//        wishButton.isWishList.toggle()
//    }
}

//extension ProductDetailViewController: ProductDetailViewDelegate {
//    func handleURLError() {
//        guard let delegate = self.productDetailViewControllerDelegate else {
//            print("ProductDetailViewControllerDelegate 설정 후 사용해주세요")
//            return
//        }
//        
//        self.navigationController?.popViewController(animated: true)
//        delegate.showInvalidUrlToast()
//    }
//}
