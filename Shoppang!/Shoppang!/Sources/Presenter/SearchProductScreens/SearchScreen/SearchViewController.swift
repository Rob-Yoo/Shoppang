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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addUserAction()
        self.observeModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let nickname = UserDefaults.standard.string(forKey: UserDefaultsKey.nickname.rawValue) ?? "옹골찬 고래밥"
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.title = nickname + "'s Shoppang!"
    }
    
    private func addUserAction() {
        self.addActionToSearchBar()
        self.addActionToSearchHistoryView()
        self.addKeyboardDismissAction()
    }
    
    private func addActionToSearchBar() {
        self.contentView.searchBar.delegate = self
    }
    
    private func addActionToSearchHistoryView() {
        let deleteAllGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteAllButtonTapped))

        self.contentView.searchHistoryView.deleteAllButton.addGestureRecognizer(deleteAllGestureRecognizer)
        self.contentView.searchHistoryView.searchHistoryTableView.delegate = self
        self.contentView.searchHistoryView.searchHistoryTableView.dataSource = self
    }
    
    private func addKeyboardDismissAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))

        self.contentView.emptyHistoryView.addGestureRecognizer(tap)
        self.contentView.searchHistoryView.searchHistoryTableView.keyboardDismissMode = .onDrag
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

        let nextVC = SearchResultViewController(query: query)
        self.model.saveSearchHistory(keyword: query)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func deleteCell(at: Int) {
        self.model.removeSearchHistory(idx: at)
    }
}


//MARK: - Observing Model
extension SearchViewController {
    private func observeModel() {
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
}

//MARK: - TableView Delegate/DataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let history = self.model.searchHistory[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.reusableIdentifier, for: indexPath) as? SearchHistoryTableViewCell else { return UITableViewCell() }
        
        cell.searchKeywordLabel.text = history.keyword
        cell.searchedDateLabel.text = history.date
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history = self.model.searchHistory[indexPath.row]
        let nextVC = SearchResultViewController(query: history.keyword)
        
        self.contentView.searchBar.text = history.keyword
        self.model.saveSearchHistory(keyword: history.keyword)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
