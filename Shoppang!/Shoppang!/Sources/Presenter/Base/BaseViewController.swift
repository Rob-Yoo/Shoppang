//
//  ViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

class BaseViewController<ContentView: UIView>: UIViewController {

    let contentView = ContentView()
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        self.configureNavigationBar()
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Configure Subviews
extension BaseViewController {
    private func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .black
        self.configureNavBarTitle()
        
        if let nc = self.navigationController, nc.viewControllers.count > 1 {
            self.configureNavBarLeftBarButtonItem()
        }
    }
    
    private func configureNavBarTitle() {
        guard let navBarInfo = self.contentView as? NavigationBarTitleProtocol else {
            print("NavigationBarTitleProtocol을 채택하지 않은 ContentView가 들어왔습니다..!")
            return
        }
            
        self.navigationItem.title = navBarInfo.navigationTitle
    }
    
    private func configureNavBarLeftBarButtonItem() {
        let backButtonImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))

        self.navigationItem.leftBarButtonItem = backButton
        UINavigationBar.appearance().tintColor = .black
    }
}

