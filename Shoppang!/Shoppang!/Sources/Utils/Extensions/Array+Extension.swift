//
//  Array+Extension.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/27/24.
//

import Foundation

extension Array where Element == Data {
    static private let encoder = JSONEncoder()
    static private let decoder = JSONDecoder()

    mutating func insert<T: Encodable>(rawData: T, at index: Int) {
        if let encodedData = try? Array<Data>.encoder.encode(rawData) {
            self.insert(encodedData, at: index)
        }
    }
    
    func convertType<T: Codable>(type: T.Type) -> [T] {
        var decodedArray = [T]()

        for data in self {
            if let decodedData = try? Array<Data>.decoder.decode(type, from: data) {
                decodedArray.append(decodedData)
            }
        }
        
        return decodedArray
    }
}
