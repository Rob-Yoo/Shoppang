//
//  SearchHistoryTableViewCell.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import SnapKit
import Then

protocol SearchViewHistoryTableViewDelegate: AnyObject {
    func deleteCell(at: Int)
}

final class SearchHistoryTableViewCell: UITableViewCell {
    
    private let clockImageView = UIImageView().then {
        $0.image = UIImage(systemName: "clock")
        $0.contentMode = .center
        $0.tintColor = .black
    }
    
    private let searchKeywordLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .regular13
        $0.numberOfLines = 1
    }
    
    private let searchedDateLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.textAlignment = .right
        $0.font = .regular13
    }
    
    private lazy var deleteButton = UIImageView().then {
        let imageConfiguration = UIImage.SymbolConfiguration(font: .regular13)
        let tap = UITapGestureRecognizer(target: self, action: #selector(deleteButtonTapped))
        
        $0.image = UIImage(systemName: "xmark", withConfiguration: imageConfiguration)
        $0.contentMode = .center
        $0.tintColor = .black
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(tap)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.configureHierarchy()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        self.contentView.addSubview(clockImageView)
        self.contentView.addSubview(searchKeywordLabel)
        self.contentView.addSubview(searchedDateLabel)
        self.contentView.addSubview(deleteButton)
    }
    
    private func configureLayout() {
        clockImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.1)
        }
        
        searchKeywordLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(clockImageView.snp.trailing).offset(5)
            $0.width.equalToSuperview().multipliedBy(0.65)
        }
        
        searchedDateLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalTo(searchKeywordLabel.snp.trailing).offset(15)
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-15)
        }
        
        deleteButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
        
        
    }
    
    func configureCellData(data: SearchHistory) {
        self.searchKeywordLabel.text = data.keyword
        self.searchedDateLabel.text = data.date
    }
    
    @objc func deleteButtonTapped() {
        guard let tableView = self.superview as? UITableView else { return }
        
        guard let indexPath = tableView.indexPath(for: self), let delegate = tableView.delegate as? SearchViewHistoryTableViewDelegate else {
            print("SearchViewHistoryTableViewDelegate 설정 후 사용해주세요")
            return
        }
        
        delegate.deleteCell(at: indexPath.row)
    }
}
