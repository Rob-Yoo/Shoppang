//
//  CartListTableViewCell.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit
import SnapKit
import Then

final class SettingListTableViewCell: UITableViewCell {
    
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .regular15
    }
    
    private lazy var cartImageView = UIImageView().then {
        $0.image = UIImage.likeSelected
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var cartListCountLabel = UILabel().then {
        $0.font = .bold15
        $0.textColor = .black
    }
    
    private lazy var suffixLabel = UILabel().then {
        $0.text = "의 상품"
        $0.textColor = .black
        $0.font = .regular15
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCellData(type: SettingListType, cartListCount: Int = 0) {
        self.titleLabel.text = type.title
        
        guard type == .cartList else { return }
        self.configureCartListCountView()
        self.cartListCountLabel.text = String(cartListCount) + "개"
    }
}

extension SettingListTableViewCell {
    private func configureTitleLabel() {
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func configureCartListCountView() {
        self.contentView.addSubview(cartImageView)
        self.contentView.addSubview(cartListCountLabel)
        self.contentView.addSubview(suffixLabel)
        
        suffixLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        cartListCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(suffixLabel.snp.leading)
            $0.centerY.equalToSuperview()
        }
        
        cartImageView.snp.makeConstraints {
            $0.trailing.equalTo(cartListCountLabel.snp.leading)
            $0.centerY.equalToSuperview()
        }
    }
}
