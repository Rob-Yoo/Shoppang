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

    static func requestAPI<T: Decodable>(req: NaverRequest, success: @escaping (_ value: T) -> Void, failure: @escaping (_ error: Error) -> Void = { error in print(error) }) {
        AF.request(req.endPoint,
                             method: req.method,
                             parameters: req.parameters,
                             encoding: URLEncoding(destination: .queryString),
                             headers: req.header)
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
    
    func requestAPI<T: Decodable>(req: NaverRequest, type: T.Type) async -> T? {
        do {
            let response = try await AF.request(req.endPoint,
                                                method: req.method,
                                                parameters: req.parameters,
                                                encoding: URLEncoding(destination: .queryString),
                                                headers: req.header)
                .validate().serializingDecodable(type).value
            
            return response
        } catch {
            print(error)
        }
        
        return nil
    }
}
