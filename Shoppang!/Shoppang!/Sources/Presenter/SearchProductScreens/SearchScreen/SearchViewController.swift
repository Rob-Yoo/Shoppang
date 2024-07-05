//
//  SearchViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import Toast
import Combine

final class SearchViewController: BaseViewController<SearchRootView> {

    private let model = SearchHistoryModel()
    private var cancellable = Set<AnyCancellable>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    override func addUserAction() {
        let deleteAllGR = UITapGestureRecognizer(target: self, action: #selector(deleteAllButtonTapped))

        self.contentView.searchHistoryView.deleteAllButton.addGestureRecognizer(deleteAllGR)
        self.contentView.searchHistoryView.searchHistoryTableView.delegate = self
        self.contentView.searchHistoryView.searchHistoryTableView.dataSource = self
        self.contentView.searchBar.delegate = self
        self.addKeyboardDismissAction()
    }
    
    override func observeModel() {
        self.model.$searchHistory
            .receive(on: RunLoop.main)
            .sink { [weak self] new in
                if (new.isEmpty) {
                    self?.contentView.presentEmptyHistoryView()
                } else {
                    self?.contentView.presentSearchHistoryView()
                    self?.contentView.searchHistoryView.searchHistoryTableView.reloadData()
                }
            }
            .store(in: &cancellable)
    }
    
    override func addKeyboardDismissAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))

        self.contentView.emptyHistoryView.addGestureRecognizer(tap)
        self.contentView.searchHistoryView.searchHistoryTableView.keyboardDismissMode = .onDrag
    }

}

//MARK: - Configure Navigation Bar
extension SearchViewController {
    private func configureNavigationBar() {
        let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? "옹골찬 고래밥"
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.title = nickname + "'s Shoppang!"
    }
}

//MARK: - User Action Handling
extension SearchViewController: UISearchBarDelegate, SearchViewHistoryTableViewDelegate {

    @objc func deleteAllButtonTapped() {
        self.model.removeAllSearchHistory()
    }
    
    @objc func keyboardDismiss() {
        self.contentView.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        let query = text.trimmingCharacters(in: .whitespaces)
        
        guard !query.isEmpty else {
            self.contentView.makeToast("검색어를 입력해주세요.", duration: 1.0, position: .center)
            return
        }

        let nextVC = SearchResultViewController(model: SearchResultModel(query: query))
        self.model.saveSearchHistory(keyword: query)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func deleteCell(at: Int) {
        self.model.removeSearchHistory(idx: at)
    }
}

//MARK: - TableView Delegate/DataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let history = self.model.searchHistory[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.reusableIdentifier, for: indexPath) as? SearchHistoryTableViewCell else { return UITableViewCell() }
        
        cell.configureCellData(data: history)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = self.model.searchHistory[indexPath.row]
        let nextVC = SearchResultViewController(model: SearchResultModel(query: history.keyword))
        
        self.contentView.searchBar.text = history.keyword
        self.model.saveSearchHistory(keyword: history.keyword)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
