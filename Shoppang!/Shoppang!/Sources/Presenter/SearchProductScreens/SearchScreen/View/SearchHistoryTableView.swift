//
//  SearchHistoryTableView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit

final class SearchHistoryTableView: UITableView {
    
    var searchHistory = [String]() {
        didSet {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: SearchHistoryTableViewCell.reusableIdentifier)
        self.showsVerticalScrollIndicator = false
        self.separatorStyle = .none
        self.rowHeight = 40
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchHistoryTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchKeyword = self.searchHistory[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.reusableIdentifier, for: indexPath) as? SearchHistoryTableViewCell else { return UITableViewCell() }
        
        cell.searchKeywordLabel.text = searchKeyword
        cell.deleteButton.tag = indexPath.row
        return cell
    }
}
