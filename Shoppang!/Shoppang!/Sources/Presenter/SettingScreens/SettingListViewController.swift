//
//  SettingListViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

final class SettingListViewController: BaseViewController<SettingListRootView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addUserAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
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
        let nextVC = EditNicknameSettingViewController()

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func update() {
        let user = UserProfile()
        let profileImage = UIImage.profileImages[user.profileImageNumber]
        
        self.contentView.profileView.update(image: profileImage, nickname: user.nickname)
        self.contentView.settingListTableView.cartListCount = user.cartListCount
    }
}

extension SettingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = SettingListType.allCases[indexPath.row]
        
        if (type == .deleteAccount) {}
    }
}

