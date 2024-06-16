//
//  SearchViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

final class SearchViewController: BaseViewController<SearchRootView> {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureNavigationBar()
        self.addUserAction()
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func addUserAction() {
        self.addActionToSearchBar()
    }
    
    private func addActionToSearchBar() {
        self.contentView.searchBar.delegate = self
    }
}

//MARK: - User Action Handling
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        let nextVC = SearchResultViewController(query: query)
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
