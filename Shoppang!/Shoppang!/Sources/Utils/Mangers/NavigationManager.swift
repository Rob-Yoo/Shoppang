//
//  NavigationManager.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/16/24.
//

import UIKit

struct NavigationManager {
    static func changeWindowScene(didDeleteAccount: Bool) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }

        let sceneDelegate = windowScene.delegate as? SceneDelegate
        let navigationController = didDeleteAccount ? UINavigationController(rootViewController: OnboardingStartViewController()) : TabBarController()
        
        sceneDelegate?.window?.rootViewController = navigationController
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
