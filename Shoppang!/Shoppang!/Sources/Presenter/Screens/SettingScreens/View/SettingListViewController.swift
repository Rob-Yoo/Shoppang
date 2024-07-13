//
//  SettingListViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import Toast

final class SettingListViewController: BaseViewController<SettingListRootView> {
    
    private var viewModel: SettingListViewModel
    
    init(viewModel: SettingListViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.inputViewWillAppearTrigger.value = ()
    }
    
    override func addUserAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileViewTapped))

        self.contentView.profileView.addGestureRecognizer(tap)
        self.contentView.settingListTableView.delegate = self
        self.contentView.settingListTableView.dataSource = self
    }
    
    override func bindViewModel() {
        self.viewModel.outputUserProfile.bind { [weak self] userProfile in
            self?.contentView.profileView.update(profile: userProfile)
        }
        
        self.viewModel.outputWishListCount.bind { [weak self] count in
            let indexPath = IndexPath(row: 0, section: 0)
            guard let wishListCountCell = self?.contentView.settingListTableView.cellForRow(at: indexPath) as? SettingListTableViewCell else { return }
            
            wishListCountCell.updateWishListCountLabel(wishListCount: count)
        }
        
        self.viewModel.outputDeleteUserAccountTrigger.bind { signal in
            if (signal != nil) {
                NavigationManager.changeWindowScene(didDeleteAccount: true)                
            }
        }
    }
}

//MARK: - TableView Delegate/DataSource
extension SettingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingListType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingListTableViewCell.reusableIdentifier, for: indexPath) as? SettingListTableViewCell else { return UITableViewCell() }
    
        let type = SettingListType.allCases[indexPath.row]
        let wishListCount = self.viewModel.outputWishListCount.value
        
        cell.configureCellData(type: type, wishListCount: wishListCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = SettingListType.allCases[indexPath.row]

        switch type {
        case .wishList:
            let nextVC = WishListViewController(model: WishListModel())
            self.navigationController?.pushViewController(nextVC, animated: true)
        case .deleteAccount:
            let alert = AlertManager.makeDeleteAccountAlert() { [weak self] _ in
                self?.viewModel.inputDeleteUserAccountButtonTapped.value = ()
            }
            self.present(alert, animated: true)
        default:
            self.contentView.makeToast("🚧 아직 준비중이에요...", duration: 1.5, position: .center)
        }
    }
}

//MARK: - User Action Handling
extension SettingListViewController {
    @objc private func profileViewTapped() {
        let nextVC = EditNicknameSettingViewController(contentView: NicknameSettingView(type: .Editing), viewModel: ProfileViewModel())
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
