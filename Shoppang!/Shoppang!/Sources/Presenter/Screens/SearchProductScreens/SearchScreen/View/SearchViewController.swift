//
//  SearchViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import Toast

final class SearchViewController: BaseViewController<SearchRootView> {

    private let viewModel = SearchHistoryViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.inputViewDidLoadTrigger.value = ()
    }
    
    override func addUserAction() {
        let deleteAllGR = UITapGestureRecognizer(target: self, action: #selector(deleteAllButtonTapped))

        self.contentView.searchHistoryView.deleteAllButton.addGestureRecognizer(deleteAllGR)
        self.contentView.searchHistoryView.searchHistoryTableView.delegate = self
        self.contentView.searchHistoryView.searchHistoryTableView.dataSource = self
        self.contentView.searchBar.delegate = self
        self.addKeyboardDismissAction()
    }
    
    override func bindViewModel() {
        self.viewModel.outputSearchHistoryList.bind { [weak self] history in
            if (history.isEmpty) {
                self?.contentView.presentEmptyHistoryView()
                self?.contentView.searchBar.text = ""
                self?.keyboardDismiss()
            } else {
                self?.contentView.presentSearchHistoryView()
                self?.contentView.searchHistoryView.searchHistoryTableView.reloadData()
            }
        }
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
        self.viewModel.inputDeleteAllButtonTapped.value = ()
    }
    
    @objc func keyboardDismiss() {
        self.contentView.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        let searchKeyword = text.trimmingCharacters(in: .whitespaces)
        
        guard !searchKeyword.isEmpty else {
            self.contentView.makeToast("검색어를 입력해주세요.", duration: 1.0, position: .center)
            return
        }

        let nextVC = SearchResultViewController(viewModel: SearchResultViewModel(searchKeyword: searchKeyword))

        self.viewModel.inputWillSaveSearchHistory.value = searchKeyword
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func deleteCell(at index: Int) {
        self.viewModel.inputWillDeleteHistoryIndex.value = index
    }
}

//MARK: - TableView Delegate/DataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.outputSearchHistoryList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let history = self.viewModel.outputSearchHistoryList.value[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.reusableIdentifier, for: indexPath) as? SearchHistoryTableViewCell else { return UITableViewCell() }
        
        cell.configureCellData(data: history)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let history =  self.viewModel.outputSearchHistoryList.value[indexPath.row]
        let nextVC = SearchResultViewController(viewModel: SearchResultViewModel(searchKeyword: history.keyword))
        
        self.viewModel.inputWillSaveSearchHistory.value = history.keyword
        self.contentView.searchBar.text = history.keyword
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
