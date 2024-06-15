//
//  ProfileImageSettingViewController.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/15/24.
//

import UIKit

final class ProfileImageSettingViewController<ContentView: UIView>: BaseViewController<ContentView> {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

#if DEBUG
import SwiftUI
struct ViewControllerRepresentable_PISVC: UIViewControllerRepresentable {
    
func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController{
    ProfileImageSettingViewController<NewProfileImageSettingView>()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PISVC_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable_PISVC()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
        }
        
    }
} #endif
