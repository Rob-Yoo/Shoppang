//
//  NetworkManager.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import Alamofire
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}

    static func requestAPI<T: Decodable>(url: String, success: @escaping (_ value: T) -> Void, failure: @escaping (_ error: Error) -> Void = { error in print(error) }) {
        AF.request(url, headers: API.headers)
            .validate()
            .responseDecodable(of: T.self) { res in
                switch res.result {
                case .success(let value):
                    success(value)
                case .failure(let error):
                    failure(error)
                }
            }
    }
    
    func requestAPI<T: Decodable>(url: String, type: T.Type) async throws -> T {
        return try await AF.request(url, headers: API.headers).validate().serializingDecodable(type).value
    }
}
