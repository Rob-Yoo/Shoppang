//
//  ReusableProtocol.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit

protocol ReusableProtocol {
    static var reusableIdentifier: String { get }
}

extension UICollectionViewCell: ReusableProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableProtocol {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
