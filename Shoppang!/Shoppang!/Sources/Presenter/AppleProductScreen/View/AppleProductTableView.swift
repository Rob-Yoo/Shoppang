//
//  AppleProductView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/25/24.
//

import UIKit
import SnapKit

final class AppleProductTableView: UITableView {

    var productTypeList = Array(repeating: SearchResultDTO(), count: AppleProductType.allCases.count) {
        didSet {
            self.reloadData()
        }
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.backgroundColor = .clear
        self.rowHeight = UIScreen.main.bounds.height * 0.3
        self.showsVerticalScrollIndicator = false
        self.allowsSelection = false
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.register(AppleProductTableViewCell.self, forCellReuseIdentifier: AppleProductTableViewCell.reusableIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppleProductTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productTypeList[0].start == -1 {
            return 0
        }
        return AppleProductType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = AppleProductType.allCases[indexPath.row].title
        let productList = self.productTypeList[indexPath.row].items

        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppleProductTableViewCell.reusableIdentifier, for: indexPath) as? AppleProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCellData(title: title, productList: productList)
        return cell
    }
}
