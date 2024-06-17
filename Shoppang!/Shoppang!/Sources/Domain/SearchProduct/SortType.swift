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
            return Literal.ButtonTitle.Sim
        case .date:
            return Literal.ButtonTitle.Date
        case .dsc:
            return Literal.ButtonTitle.Dsc
        case .asc:
            return Literal.ButtonTitle.Asc
        }
    }
}
