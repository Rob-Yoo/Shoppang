//
//  SettingListTableView.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/17/24.
//

import UIKit

final class SettingListTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.isScrollEnabled = false
        self.delegate = self
        self.dataSource = self
        self.register(SettingListTableViewCell.self, forCellReuseIdentifier: SettingListTableViewCell.reusableIdentifier)
        self.rowHeight = 50
        self.separatorColor = .black
        self.separatorStyle = .singleLine
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingListType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = SettingListType.allCases[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingListTableViewCell.reusableIdentifier, for: indexPath) as? SettingListTableViewCell else { return UITableViewCell() }
        
        cell.configureCellData(type: type, cartListCount: 15)
        return cell
    }

}
