//
//  SettingListViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import Toast

final class SettingListViewController: BaseViewController<SettingListRootView> {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkUserProfile()
    }
    
    override func addUserAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileViewTapped))

        self.contentView.profileView.addGestureRecognizer(tap)
        self.contentView.settingListTableView.delegate = self
    }
    
    func checkUserProfile() {
        let user = UserProfile()
        let profileImage = UIImage.profileImages[user.profileImageNumber]
        
        self.contentView.profileView.update(image: profileImage, nickname: user.nickname)
        self.contentView.settingListTableView.cartListCount = user.cartListCount
    }
}

//MARK: - User Action Handling
extension SettingListViewController: UITableViewDelegate {
    
    @objc private func profileViewTapped() {
        let nextVC = EditNicknameSettingViewController()

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = SettingListType.allCases[indexPath.row]

        if (type == .deleteAccount) {
            let alert = AlertManager.makeDeleteAccountAlert(handler: deleteUserAccount)
            self.present(alert, animated: true)
        } else {
            self.contentView.makeToast("🚧 아직 준비중이에요...", duration: 1.5, position: .center)
        }
    }
}

extension SettingListViewController {
    private func deleteUserAccount(_ action: UIAlertAction) {
        UserDefaultsKey.allCases.forEach {
            UserDefaults.standard.removeObject(forKey: $0.rawValue)
        }
        NavigationManager.changeWindowScene(didDeleteAccount: true)
    }
}
