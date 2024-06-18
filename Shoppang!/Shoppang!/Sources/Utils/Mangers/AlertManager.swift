//
//  AlertManager.swift
//  Shoppang!
//
//  Created by Jinyoung Yoo on 6/18/24.
//

import UIKit

struct AlertManager {
    static func makeDeleteAccountAlert(handler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다.\n탈퇴 하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .destructive, handler: handler)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        return alert
    }
}
