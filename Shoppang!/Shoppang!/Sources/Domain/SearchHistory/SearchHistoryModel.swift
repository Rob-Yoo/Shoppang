//
//  SearchHistoryModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation
import Combine

struct SearchHistory: Codable {
    let keyword: String
    let date: String
}

final class SearchHistoryModel {
    @Published var searchHistory: [SearchHistory]

    private var encodedHistory: [Data] {
        didSet {
            UserDefaults.standard.setValue(encodedHistory, forKey: UserDefaultsKey.searchHistory.rawValue)
        }
    }
    
    init() {
        guard let history = UserDefaults.standard.array(forKey: UserDefaultsKey.searchHistory.rawValue) as? [Data] else {
            self.encodedHistory = []
            self.searchHistory = []
            return
        }
        
        self.encodedHistory = history
        self.searchHistory = history.convertType(type: SearchHistory.self)
    }
    
    func saveSearchHistory(keyword: String) {
        let date = String.getCurrentDate(dateFormat: "MM.dd.")
        let history = SearchHistory(keyword: keyword, date: date)

        
        for (idx, history) in searchHistory.enumerated() {
            if (history.keyword == keyword) {
                self.removeSearchHistory(idx: idx)
                break
            }
        }
        
        encodedHistory.insert(rawData: history, at: 0)
        searchHistory.insert(history, at: 0)
    }
    
    func removeSearchHistory(idx: Int) {
        self.searchHistory.remove(at: idx)
        self.encodedHistory.remove(at: idx)
    }
    
    func removeAllSearchHistory() {
        self.searchHistory.removeAll()
        self.encodedHistory.removeAll()
    }
}

