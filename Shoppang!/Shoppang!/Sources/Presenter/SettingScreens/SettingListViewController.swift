//
//  SettingListViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

final class SettingListViewController: BaseViewController<SettingListRootView> {

    private let model = NewProfileModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addUserAction()
    }
    
    private func addUserAction() {
        self.addActionToProfileView()
    }
    
    private func addActionToProfileView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileViewTapped))
        self.contentView.profileView.addGestureRecognizer(tap)
    }
    
    private func addActionToDeleteAccountCell() {
        self.contentView.settingListTableView.delegate = self
    }
    
    @objc private func profileViewTapped() {
        let nextVC = EditNicknameSettingViewController(model: self.model)

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SettingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = SettingListType.allCases[indexPath.row]
        
        if (type == .deleteAccount) {}
    }
}

