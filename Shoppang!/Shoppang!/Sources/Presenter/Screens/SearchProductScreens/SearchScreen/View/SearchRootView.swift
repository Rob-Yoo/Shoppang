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
    var navigationTitle: String = Literal.NavigationTitle.Search
    
    let searchBar = UISearchBar().then {
        $0.placeholder = Literal.Placeholder.Search
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
    
    func presentSearchHistoryView() {
        self.searchHistoryView.isHidden = false
        self.emptyHistoryView.isHidden = true
    }
    
    func presentEmptyHistoryView() {
        self.searchHistoryView.isHidden = true
        self.emptyHistoryView.isHidden = false
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
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
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
