//
//  AppleProductTableViewCell.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit
import SnapKit
import Then

final class AppleProductTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .bold16
    }
    
    lazy var productCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout()).then {
        $0.backgroundColor = .mainTheme
        $0.register(AppleProductCollectionViewCell.self, forCellWithReuseIdentifier: AppleProductCollectionViewCell.reusableIdentifier)
        $0.showsHorizontalScrollIndicator = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 3) / 2.5
        let height = width * 1.3
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 1
        return layout
    }
}

extension AppleProductTableViewCell {
    private func configureHierarchy() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(productCollectionView)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        productCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureCellData(title: String) {
        self.titleLabel.text = title
    }
}

//extension AppleProductTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.productList.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let data = self.productList[indexPath.item]
//        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppleProductCollectionViewCell.reusableIdentifier, for: indexPath) as? AppleProductCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        
//        cell.configureCellData(data: data)
//        return cell
//    }
//}
