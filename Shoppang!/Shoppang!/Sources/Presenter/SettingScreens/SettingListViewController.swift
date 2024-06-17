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
        self.checkUserProfile()
    }
    
    private func addUserAction() {
        self.addActionToProfileView()
        self.addActionToDeleteAccountCell()
    }
    
    private func addActionToProfileView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileViewTapped))
        self.contentView.profileView.addGestureRecognizer(tap)
    }
    
    private func addActionToDeleteAccountCell() {
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
            showAlert()
        }
    }
}

extension SettingListViewController {
    private func showAlert() {
        let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다.\n탈퇴 하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: deleteUserAccount)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    private func deleteUserAccount(_ action: UIAlertAction) {
        UserDefaultsKey.allCases.forEach {
            UserDefaults.standard.removeObject(forKey: $0.rawValue)
        }
        NavigationManager.changeWindowScene(didDeleteAccount: true)
    }
}
