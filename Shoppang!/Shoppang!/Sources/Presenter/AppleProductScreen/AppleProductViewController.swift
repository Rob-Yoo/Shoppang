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

    override func loadView() {
        super.loadView()
        self.model.fetchAppleProductResult()        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.makeToastActivity(.center)
        self.addDelegate()
    }
    
    private func addDelegate() {
        self.contentView.appleProductTableView.delegate = self
        self.contentView.appleProductTableView.dataSource = self
    }
    
    override func observeModel() {
        self.model.$appleProductList
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                self?.contentView.hideToastActivity()
                self?.contentView.appleProductTableView.reloadData()
            }
            .store(in: &cancellable)
    }
}

extension AppleProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.appleProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = AppleProductType.allCases[indexPath.row].title

        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppleProductTableViewCell.reusableIdentifier, for: indexPath) as? AppleProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCellData(title: title)
        cell.productCollectionView.delegate = self
        cell.productCollectionView.dataSource = self
        cell.productCollectionView.tag = indexPath.row
        return cell
    }
}

extension AppleProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let idx = collectionView.tag
        return self.model.appleProductList[idx].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let idx = collectionView.tag
        let product = self.model.appleProductList[idx].items[indexPath.item]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppleProductCollectionViewCell.reusableIdentifier, for: indexPath) as? AppleProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCellData(data: product)
        return cell
    }
}
