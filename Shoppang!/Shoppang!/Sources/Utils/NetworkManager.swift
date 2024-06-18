//
//  NetworkManager.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import Alamofire
import Network

struct NetworkManager {
    private static let monitor = NWPathMonitor()
    private static var isConnectedNetwork = true
    
    static func requestURL<T: Decodable>(url: String, success: @escaping (_ value: T) -> Void, failure: @escaping (_ error: Error) -> Void = { error in print(error) }) {
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
    
    static func startNetworkMonitoring() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied && isConnectedNetwork == false {
                // 네트워크 재연결
                isConnectedNetwork.toggle()
            } else if path.status == .unsatisfied && isConnectedNetwork == true {
                // 네트워크 연결 실패
                isConnectedNetwork.toggle()
            }
        }
        
        monitor.start(queue: DispatchQueue.global())
    }
    
    static func stopNetworkMonitoring() {
        monitor.cancel()
    }
}
