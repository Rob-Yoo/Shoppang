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
    
    private let wishListCountLabel = UILabel().then {
        $0.textColor = .mainTheme
        $0.font = .bold15
    }
    
    private let sortTitleLabel = UILabel().then {
        $0.font = .medium15
        $0.textColor = .black
        $0.text = WishListSortType.add.title
    }
    
    private let arrowImageView = UIImageView().then {
        let config = UIImage.SymbolConfiguration(font: .regular13)

        $0.image = UIImage(systemName: "chevron.down", withConfiguration: config)
        $0.contentMode = .center
        $0.tintColor = .black
    }
    
    let transparentButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.showsMenuAsPrimaryAction = true
    }
    
    lazy var wishListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
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
    
    func update(wishListCount: Int) {
        self.wishListCountLabel.text = wishListCount.formatted() + "개의 찜한 상품"
    }
    
    func update(sortType: WishListSortType) {
        self.sortTitleLabel.text = sortType.title
    }
}

//MARK: - Configure Subviews
extension WishListRootView {
    private func configureHierarchy() {
        self.addSubview(wishListCountLabel)
        self.addSubview(sortTitleLabel)
        self.addSubview(arrowImageView)
        self.addSubview(transparentButton)
        self.addSubview(wishListCollectionView)
    }
    
    private func configureLayout() {
        
        wishListCountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        sortTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(sortTitleLabel.snp.trailing)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(sortTitleLabel.snp.height)
        }

        wishListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(wishListCountLabel).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        transparentButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalToSuperview().multipliedBy(0.15)
            make.bottom.equalTo(wishListCollectionView.snp.top).offset(-20)
        }
    }

}
