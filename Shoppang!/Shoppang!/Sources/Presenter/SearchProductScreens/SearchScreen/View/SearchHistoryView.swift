//
//  SearchedListView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit
import SnapKit
import Then

final class SearchHistoryView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.text = "최근 검색"
        $0.textColor = .black
        $0.font = .bold14
    }
    
    let deleteAllButton = UILabel().then {
        $0.text = Literal.ButtonTitle.DeleteAll
        $0.textColor = .mainTheme
        $0.font = .regular14
        $0.isUserInteractionEnabled = true
    }
    
    let searchHistoryTableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: SearchHistoryTableViewCell.reusableIdentifier)
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.rowHeight = 40
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
extension SearchHistoryView {
    private func configureHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(deleteAllButton)
        self.addSubview(searchHistoryTableView)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(15)
        }
        
        deleteAllButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(15)
            $0.size.equalTo(titleLabel.snp.size)
        }
        
        searchHistoryTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(5)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
