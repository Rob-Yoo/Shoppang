//
//  EmptySearchedListView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import SnapKit
import Then

final class EmptySearchHistoryView: UIView {

    private let imageView = UIImageView().then {
        $0.image = .empty
        $0.contentMode = .center
    }
    
    private let descriptionLabel = UILabel().then {
        $0.text = "최근 검색어가 없어요"
        $0.textColor = .black
        $0.font = .bold15
        $0.textAlignment = .center
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
extension EmptySearchHistoryView {
    private func configureHierarchy() {
        self.addSubview(imageView)
        self.addSubview(descriptionLabel)
    }
    
    private func configureLayout() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
            $0.size.equalToSuperview().multipliedBy(0.5)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}
