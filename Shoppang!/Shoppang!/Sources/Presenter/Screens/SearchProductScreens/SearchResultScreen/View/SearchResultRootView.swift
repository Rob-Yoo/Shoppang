//
//  SearchResultRootView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import SnapKit
import Then

final class SearchResultRootView: UIView {
    let totalCountLabel = UILabel().then {
        $0.textColor = .mainTheme
        $0.font = .bold15
    }
    
    let sortButtonsView = SortButtonsView()
    
    let productListCollectionView = SearchResultCollectionView() {
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

}

//MARK: - Configure Subviews
extension SearchResultRootView {
    private func configureHierarchy() {
        self.addSubview(totalCountLabel)
        self.addSubview(sortButtonsView)
        self.addSubview(productListCollectionView)
    }
    
    private func configureLayout() {
        totalCountLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        sortButtonsView.snp.makeConstraints {
            $0.top.equalTo(totalCountLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(0.04)
        }
        
        productListCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortButtonsView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
