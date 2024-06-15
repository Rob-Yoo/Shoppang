//
//  ProfileSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/14/24.
//

import UIKit

class InitialProfileSettingViewController: BaseViewController<InitialProfileSettingView> {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

#if DEBUG
import SwiftUI
struct ViewControllerRepresentable_KMVC: UIViewControllerRepresentable {
    
func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController{
    InitialProfileSettingViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_KMVC_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable_KMVC()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
        }
        
    }
} #endif
