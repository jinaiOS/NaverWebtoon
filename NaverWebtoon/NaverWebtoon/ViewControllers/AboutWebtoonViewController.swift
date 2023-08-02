//
//  AboutWebtoonViewController.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/08/01.
//

import UIKit

class AboutWebtoonViewController: UIViewController {

    @IBOutlet weak var ivMain: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    
    var id : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.requestTodayWebtoon()
        
    }
    
    func requestTodayWebtoon() {
        Repository().requestWebtoonInfo(id: id) {[weak self] result in
            guard let `self` = self else {return}
            switch result {
            case .success(let data):
                Log.d(data)
                if let data = data {
                    if data.thumb != "" {
                        self.ivMain.isHidden = false
                        self.ivMain.load(url: URL(string: data.thumb ?? "")!)
                    } else {
                        self.ivMain.isHidden = true
                    }
                    self.lblTitle.text = data.title ?? ""
                    self.lblAbout.text = data.about ?? ""
                    self.lblGenre.text = data.genre ?? ""
                    self.lblAge.text = data.age ?? ""
                }
            case .failure(let error):
                Log.e(error)
            }
        }
    }

}
