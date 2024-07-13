//
//  NaverRequest.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 7/13/24.
//

import Foundation
import Alamofire

enum NaverRequest {
    case shopping(query: String, sort: String, start: Int)
    
    private var baseURL: String {
        return "https://openapi.naver.com/v1"
    }
    
    var endPoint: String {
        switch self {
        case .shopping(_, _, _):
            return baseURL + "/search/shop.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .shopping(_, _, _):
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .shopping(let query, let sort, let start):
            return ["query": query, "sort": sort, "start": start, "display": 30]
        }
    }
    
    var header: HTTPHeaders {
        return ["X-Naver-Client-Id": API.clientID, "X-Naver-Client-Secret": API.clientSecret]
    }
}
