//
//  SearchResultViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit

final class SearchResultViewController: BaseViewController<SearchResultRootView> {

    private let navigationTitle: String
    
    init(query navigationTitle: String) {
        self.navigationTitle = navigationTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationTitle()
    }
    
    private func configureNavigationTitle() {
        self.navigationItem.title = self.navigationTitle
    }
}
