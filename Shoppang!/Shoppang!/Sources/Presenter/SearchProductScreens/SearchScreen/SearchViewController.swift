//
//  SearchViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
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
    }
    
    private func addKeyboardDismissAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))

        self.contentView.emptyHistoryView.addGestureRecognizer(tap)
        self.contentView.searchHistoryView.searchHistoryTableView.keyboardDismissMode = .onDrag
    }

}

//MARK: - User Action Handling
extension SearchViewController: UISearchBarDelegate, UITableViewDelegate, SearchViewHistoryTableViewDelegate {

    @objc func deleteAllButtonTapped() {
        self.model.searchHistory = []
    }
    
    @objc func keyboardDismiss() {
        self.contentView.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        let nextVC = SearchResultViewController(query: query)
        
        self.model.saveSearchHistory(keyword: query)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = self.model.searchHistory[indexPath.row]
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
                self?.contentView.decideSearchHistoryView(searchHistory: new)
            }
            .store(in: &cancellable)
    }
}
