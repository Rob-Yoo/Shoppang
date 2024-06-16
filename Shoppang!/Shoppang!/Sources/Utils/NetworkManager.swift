//
//  NetworkManager.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import Alamofire

struct NetworkManager {
    static func requestURL<T: Decodable>(url: String, success: @escaping (_ value: T) -> Void, failure: @escaping (_ error: Error) -> Void = { error in print(error) }) {
        AF.request(url, headers: API.headers)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: T.self) { res in
                switch res.result {
                case .success(let value):
                    success(value)
                case .failure(let error):
                    failure(error)
                }
            }
    }
}
