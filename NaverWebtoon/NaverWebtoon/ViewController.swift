//
//  ViewController.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/07/28.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestTodayWebtoon()
    }
     
    func requestTodayWebtoon() {
        Repository().requestTodayWebtoon {[weak self] result in
            guard let `self` = self else {return}
            switch result {
            case .success(let data):
                Log.d(data)
                //                self.versionCheck(versionInfo: data)
            case .failure(let error):
                Log.e(error)
            }
        }
    }
    
}

