//
//  SearchRootView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import SnapKit
import Then

final class SearchRootView: UIView, RootViewProtocol {
    var navigationTitle: String = "\(UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue)!)'s Shoppang!"
    
    let searchBar = UISearchBar().then {
        $0.placeholder = Placeholder.searchBarPlaceholder
        $0.searchBarStyle = .minimal
    }
    
    let line = UIView().then {
        $0.backgroundColor = .placeholder
    }
    
    let emptyHistoryView = EmptySearchHistoryView()
    
    let searchHistoryView = SearchHistoryView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func decideSearchHistoryView(searchHistory: [String]) {
        if (searchHistory.isEmpty) {
            self.searchHistoryView.isHidden = true
            self.emptyHistoryView.isHidden = false
        } else {
            self.searchHistoryView.isHidden = false
            self.emptyHistoryView.isHidden = true
            self.searchHistoryView.searchHistoryTableView.searchHistory = searchHistory
        }
    }
}

//MARK: - Configure Subviews
extension SearchRootView {
    
    private func configureSubviews() {
        self.configureSearchBar()
        self.configureLine()
        self.configureEmptySearchHistoryView()
        self.configureSearchHistoryView()
    }
    
    private func configureSearchBar() {
        self.addSubview(searchBar)
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
    }
    
    private func configureLine() {
        self.addSubview(line)
        
        line.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    private func configureEmptySearchHistoryView() {
        self.addSubview(emptyHistoryView)
        
        emptyHistoryView.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func configureSearchHistoryView() {
        self.addSubview(searchHistoryView)
        
        searchHistoryView.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }

}
