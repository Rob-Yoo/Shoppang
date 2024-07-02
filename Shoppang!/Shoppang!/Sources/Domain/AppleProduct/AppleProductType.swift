//
//  AppleProductType.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import Foundation

enum AppleProductType: CaseIterable {
    case iPhone
    case iPad
    case MacBook
    case iMac
    case AppleWatch
    case AirPods
    case iPod
    case AppleTV
    case homePod
    
    var title: String {
        switch self {
        case .iPhone:
            return "iPhone"
        case .iPad:
            return "iPad"
        case .MacBook:
            return "MacBook"
        case .iMac:
            return "iMac"
        case .AppleWatch:
            return "Apple Watch"
        case .AirPods:
            return "AirPods"
        case .iPod:
            return "iPod"
        case .AppleTV:
            return "AppleTV"
        case .homePod:
            return "HomePod"
        }
    }
    
    var url: String {
        return API.searchProductURL(query: self.title, sort: SortType.sim.rawValue, page: 1)
    }
    
}
