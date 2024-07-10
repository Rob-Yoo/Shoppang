//
//  SearchHistoryModel.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation
import Combine

final class SearchHistoryViewModel {
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputWillSaveSearchHistory: Observable<String?> = Observable(nil)
    var inputDeleteAllButtonTapped: Observable<Void?> = Observable(nil)
    var inputWillDeleteHistoryIndex: Observable<Int?> = Observable(nil)
    
    var outputSearchHistoryList: Observable<[SearchHistory]> = Observable([])
    
    private var encodedHistory: [Data] = [] {
        didSet {
            UserDefaults.standard.setValue(encodedHistory, forKey: UserDefaultsKey.searchHistory.rawValue)
        }
    }
    
    init() {
        self.transform()
    }
    
    private func transform() {
        self.inputViewDidLoadTrigger.bind { [weak self] _ in
            self?.loadSearchHistory()
        }
        
        self.inputWillSaveSearchHistory.bind { [weak self] history in
            guard let keword = history else { return }
            self?.saveSearchHistory(keyword: keword)
        }
        
        self.inputDeleteAllButtonTapped.bind { [weak self] signal in
            if (signal != nil) {
                self?.removeAllSearchHistory()
            }
        }
        
        self.inputWillDeleteHistoryIndex.bind { [weak self] index in
            guard let index = index else { return }
            self?.removeSearchHistory(idx: index)
        }
    }
}

//MARK: - Load Search History
extension SearchHistoryViewModel {
    private func loadSearchHistory() {
        guard let history = UserDefaults.standard.array(forKey: UserDefaultsKey.searchHistory.rawValue) as? [Data] else {
            self.outputSearchHistoryList.value = []
            return
        }
        
        self.encodedHistory = history
        self.outputSearchHistoryList.value = history.convertType(type: SearchHistory.self)
    }
}

//MARK: - Add/Delete Search History
extension SearchHistoryViewModel {
    private func saveSearchHistory(keyword: String) {
        let date = String.getCurrentDate(dateFormat: "MM.dd.")
        let history = SearchHistory(keyword: keyword, date: date)

        
        for (idx, history) in outputSearchHistoryList.value.enumerated() {
            if (history.keyword == keyword) {
                self.removeSearchHistory(idx: idx)
                break
            }
        }
        
        self.encodedHistory.insert(rawData: history, at: 0)
        self.outputSearchHistoryList.value.insert(history, at: 0)
    }
    
    private func removeSearchHistory(idx: Int) {
        self.encodedHistory.remove(at: idx)
        self.outputSearchHistoryList.value.remove(at: idx)
    }
    
    private func removeAllSearchHistory() {
        self.encodedHistory.removeAll()
        self.outputSearchHistoryList.value.removeAll()
    }
}

