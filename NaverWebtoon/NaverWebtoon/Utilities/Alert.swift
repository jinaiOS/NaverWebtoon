//
//  Alert.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/07/31.
//

import Foundation
import UIKit

struct Alert {
    //1개버튼 타입 Alert
    static func showOneButtonAlertController(title : String, subTitle: String? = nil, buttonTitle: String = "확인", okActionHandler : (() -> (Void))? = nil) {
        DispatchQueue.main.async {
            let sheet = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
            sheet.addAction(UIAlertAction(title: buttonTitle, style: .destructive, handler: { _ in }))
        }
    }
    
    //2개버튼 타입 Alert
    static func showTwoButtonAlertController(title : String, subTitle: String? = nil, cancelTitle : String = "아니오", okTitle : String = "네", cancelHandler : (() -> (Void))? = nil,  okActionHandler : (() -> (Void))?) {
        DispatchQueue.main.async {
            let sheet = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
            sheet.addAction(UIAlertAction(title: cancelTitle, style: .destructive, handler: { _ in }))
            sheet.addAction(UIAlertAction(title: okTitle, style: .destructive, handler: { _ in }))
        }
    }
}
