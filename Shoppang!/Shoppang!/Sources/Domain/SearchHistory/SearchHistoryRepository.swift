//
//  SearchHistoryRepository.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/11/24.
//

import Foundation

final class SearchHistoryRepository {
    private var encodedHistory: [Data] = [] {
        didSet {
            UserDefaults.standard.setValue(encodedHistory, forKey: UserDefaultsKey.searchHistory.rawValue)
        }
    }
    
    var decodedHistory: [SearchHistoryModel] {
        return encodedHistory.convertType(type: SearchHistoryModel.self)
    }
    
    func loadSearchHistory() -> [SearchHistoryModel] {
        guard let history = UserDefaults.standard.array(forKey: UserDefaultsKey.searchHistory.rawValue) as? [Data] else {
            return []
        }
        
        self.encodedHistory = history
        return self.decodedHistory
    }
    
    func saveSearchHistory(keyword: String) {
        let date = String.getCurrentDate(dateFormat: "MM.dd.")
        let history = SearchHistoryModel(keyword: keyword, date: date)

        
        for (idx, history) in decodedHistory.enumerated() {
            if (history.keyword == keyword) {
                self.removeSearchHistory(idx: idx)
                break
            }
        }
        
        self.encodedHistory.insert(rawData: history, at: 0)
    }
    
    func removeSearchHistory(idx: Int) {
        self.encodedHistory.remove(at: idx)
    }
    
    func removeAllSearchHistory() {
        self.encodedHistory.removeAll()
    }
}
