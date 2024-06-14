//
//  TabBarController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit
import Then

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTabBarController()
    }

    private func configureTabBarController() {
        self.tabBar.backgroundColor = .systemBackground
        
        self.viewControllers = Tab.allCases.map {
            let (title, icon) = $0.itemResource
            
            return UINavigationController(rootViewController: $0.viewController).then {
                $0.tabBarItem = UITabBarItem(title: title, image: icon, selectedImage: icon)
            }
        }
        
        UITabBar.appearance().tintColor = .mainTheme
        UITabBar.appearance().unselectedItemTintColor = .unselectedTabBar
    }

}

extension TabBarController {
    typealias TabItemResource = (title: String, icon: UIImage?)
    
    enum Tab: CaseIterable {
        case search
        case setting
        
        var viewController: UIViewController {
            switch self {
            case .search:
                return SearchViewController()
            case .setting:
                return SettingListViewController()
            }
        }
        
        var itemResource: TabItemResource {
            switch self {
            case .search:
                return (title: "검색", icon: UIImage(systemName: "magnifyingglass"))
            case .setting:
                return (title: "설정", icon: UIImage(systemName: "person"))
            }
        }
    }
}
