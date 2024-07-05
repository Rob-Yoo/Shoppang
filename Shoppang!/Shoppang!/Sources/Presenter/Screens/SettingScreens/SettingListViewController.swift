//
//  SettingListViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import Toast

final class SettingListViewController: BaseViewController<SettingListRootView> {
    
    private var cartListCount = 0 {
        didSet {
            if (oldValue != cartListCount) {
                let indexPath = IndexPath(row: 0, section: 0)
                guard let cartListCountCell = contentView.settingListTableView.cellForRow(at: indexPath) as? SettingListTableViewCell else { return }
                
                cartListCountCell.updateCartListCountLabel(cartListCount: cartListCount)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkUserProfile()
    }
    
    override func addUserAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileViewTapped))

        self.contentView.profileView.addGestureRecognizer(tap)
        self.contentView.settingListTableView.delegate = self
        self.contentView.settingListTableView.dataSource = self
    }
    
    func checkUserProfile() {
        let user = UserProfile()

        self.contentView.profileView.update(profile: user)
        self.cartListCount = user.cartListCount
    }
}

//MARK: - TableView Delegate/DataSource
extension SettingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingListType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = SettingListType.allCases[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingListTableViewCell.reusableIdentifier, for: indexPath) as? SettingListTableViewCell else { return UITableViewCell() }
        
        cell.configureCellData(type: type, cartListCount: self.cartListCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = SettingListType.allCases[indexPath.row]

        switch type {
        case .cartList:
            let nextVC = CartListViewController(model: CartListModel())
            self.navigationController?.pushViewController(nextVC, animated: true)
        case .deleteAccount:
            let alert = AlertManager.makeDeleteAccountAlert(handler: deleteUserAccount)
            self.present(alert, animated: true)
        default:
            self.contentView.makeToast("🚧 아직 준비중이에요...", duration: 1.5, position: .center)
        }
    }
}

//MARK: - User Action Handling
extension SettingListViewController {
    
    @objc private func profileViewTapped() {
        let nextVC = EditNicknameSettingViewController(contentView: NicknameSettingView(type: .Editing), model: EditProfileModel())

        self.navigationController?.pushViewController(nextVC, animated: true)
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
