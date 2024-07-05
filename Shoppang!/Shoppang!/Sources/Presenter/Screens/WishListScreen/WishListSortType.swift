//
//  WishListFilterType.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/6/24.
//

import Foundation

enum WishListSortType: CaseIterable {
    case add, asc, dsc, mallName
    
    var title: String {
        switch self {
        case .add:
            return Literal.WishListSort.Add
        case .asc:
            return Literal.WishListSort.Asc
        case .dsc:
            return Literal.WishListSort.Dsc
        case .mallName:
            return Literal.WishListSort.MallName
        }
    }
}
