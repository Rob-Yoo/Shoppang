//
//  WishListRootView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/5/24.
//

import UIKit
import SnapKit
import Then

final class WishListRootView: UIView, RootViewProtocol {
    let navigationTitle = Literal.NavigationTitle.WishList
    
    lazy var productCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reusableIdentifier)
        $0.showsVerticalScrollIndicator = false
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 60) / 2
        let height = width * 1.4

        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 20
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        self.addSubview(productCollectionView)
    }
    
    private func configureLayout() {
        productCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
