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

    private let viewModel: ProductDetailViewModel
    
    weak var productDetailViewControllerDelegate: ProductDetailViewControllerDelegate?
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (self.viewModel.inputLoadProductDetailTrigger.value == nil) {
            self.viewModel.inputLoadProductDetailTrigger.value = ()
        } else {
            self.viewModel.inputShouldUpdateWishStatus.value = ()
        }
    }
    
    override func addUserAction() {
        self.contentView.handleURLError = { [weak self] in
            guard let delegate = self?.productDetailViewControllerDelegate else {
                print("ProductDetailViewControllerDelegate 설정 후 사용해주세요")
                return
            }
            
            self?.navigationController?.popViewController(animated: true)
            delegate.showInvalidUrlToast()
        }
    }
    
    override func bindViewModel() {
        self.viewModel.outputProduct.bind { [weak self] product in
            guard let product = product else { return }
            self?.configureNavigationBar(product: product)
            self?.contentView.loadWebView(url: product.link)
        }
        
        self.viewModel.outputIsWishList.bind { [weak self] isWishList in
            guard let isWishList = isWishList else { return }
            let toastMessage = isWishList ? "찜 목록에 추가되었습니다." : "찜 목록에서 삭제되었습니다."
            
            self?.updateWishListButton(isWishList: isWishList)
            self?.contentView.makeToast(toastMessage, duration: 1, position: .center)
        }
        
        self.viewModel.outputUpdatedWishStatus.bind { [weak self] isWishList in
            guard let isWishList = isWishList else { return }
            self?.updateWishListButton(isWishList: isWishList)
        }
    }
    
    private func configureNavigationBar(product: ProductModel) {
        let isWishList = product.isWishList
        let button = WishListBarButton(isWishList: isWishList)
        let barbutton = UIBarButtonItem(customView: button)
        
        self.navigationItem.title = product.title.htmlElementDeleted
        self.navigationItem.rightBarButtonItem = barbutton
        button.addTarget(self, action: #selector(wishButtonTapped), for: .touchUpInside)
    }
}

//MARK: - User Action Handling
extension ProductDetailViewController {
    @objc private func wishButtonTapped() {
        self.viewModel.inputWishButtonTapped.value = ()
    }
}

//MARK: - Update UI
extension ProductDetailViewController {
    private func updateWishListButton(isWishList: Bool) {
        guard let wishButton = self.navigationItem.rightBarButtonItem?.customView as? WishListBarButton else { return }
        
        wishButton.isWishList = isWishList
    }
}
