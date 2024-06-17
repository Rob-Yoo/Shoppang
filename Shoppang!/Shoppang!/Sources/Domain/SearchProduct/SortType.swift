//
//  SortType.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import Foundation

enum SortType: String {
    case sim
    case date
    case asc
    case dsc
    
    var title: String {
        switch self {
        case .sim:
            return "정확도"
        case .date:
            return "날짜순"
        case .dsc:
            return "가격높은순"
        case .asc:
            return "가격낮은순"
        }
    }
}
