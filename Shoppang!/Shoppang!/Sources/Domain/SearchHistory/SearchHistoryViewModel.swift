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
    
    private let repository = SearchHistoryRepository()
    
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

//MARK: - Load/Add/Delete Search History
extension SearchHistoryViewModel {
    private func loadSearchHistory() {
        self.outputSearchHistoryList.value = repository.loadSearchHistory()
    }
    
    private func saveSearchHistory(keyword: String) {
        repository.saveSearchHistory(keyword: keyword)
        self.outputSearchHistoryList.value = repository.decodedHistory
    }
    
    private func removeSearchHistory(idx: Int) {
        repository.removeSearchHistory(idx: idx)
        self.outputSearchHistoryList.value = repository.decodedHistory
    }
    
    private func removeAllSearchHistory() {
        repository.removeAllSearchHistory()
        self.outputSearchHistoryList.value = repository.decodedHistory
    }
}

