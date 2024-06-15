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

//MARK: - Configure NavigationBar
extension BaseViewController {
    private func configureNavigationBar() {
        self.configureNavBarAppearence()
        self.configureNavBarTitle()
        
        if let nc = self.navigationController, nc.viewControllers.count > 1 {
            self.configureNavBarLeftBarButtonItem()
        }
    }
    
    private func configureNavBarAppearence() {
        let appearence = UINavigationBarAppearance()
        
        appearence.configureWithOpaqueBackground()
        self.navigationController?.navigationBar.standardAppearance = appearence
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearence
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureNavBarTitle() {
        guard let navBarInfo = self.contentView as? RootViewProtocol else {
            print("RootViewProtocol을 채택하지 않은 ContentView가 들어왔습니다..!")
            return
        }
            
        self.navigationItem.title = navBarInfo.navigationTitle
    }
    
    private func configureNavBarLeftBarButtonItem() {
        let backButtonImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))

        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.leftBarButtonItem?.tintColor = .black
    }
}

