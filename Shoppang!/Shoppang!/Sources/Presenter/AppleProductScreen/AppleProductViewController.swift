//
//  AppleProductViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit
import Combine
import Toast

class AppleProductViewController: BaseViewController<AppleProductRootView> {

    private let model = AppleProductModel()
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.makeToastActivity(.center)
        self.observeModel()
    }
}

//MARK: - Observe Model
extension AppleProductViewController {
    private func observeModel() {
        self.model.$appleProductList
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.contentView.appleProductTableView.productTypeList = new
                self?.contentView.hideToastActivity()
            }
            .store(in: &cancellable)
    }
}
