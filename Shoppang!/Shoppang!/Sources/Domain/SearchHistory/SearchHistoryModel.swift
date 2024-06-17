//
//  SearchHistoryModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation
import Combine

final class SearchHistoryModel {
    @Published var searchHistory: [String]
    
    init() {
        guard let history = UserDefaults.standard.array(forKey: UserDefaultsKey.searchHistory.rawValue), let searchHistory = history as? [String] else {
            self.searchHistory = []
            return
        }
        
        self.searchHistory = searchHistory
    }
    
    func saveSearchHistory(keyword: String) {
        if let idx = self.searchHistory.firstIndex(of: keyword) {
            searchHistory.remove(at: idx)
        }
        
        searchHistory.insert(keyword, at: 0)
        
        if (searchHistory.count > 100) { searchHistory.removeLast() }

        UserDefaults.standard.setValue(searchHistory, forKey: UserDefaultsKey.searchHistory.rawValue)
    }
    
    func removeSearchHistory(idx: Int) {
        self.searchHistory.remove(at: idx)
        UserDefaults.standard.setValue(searchHistory, forKey: UserDefaultsKey.searchHistory.rawValue)
    }
}
