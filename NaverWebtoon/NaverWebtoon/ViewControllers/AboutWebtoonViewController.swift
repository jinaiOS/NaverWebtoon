//
//  AboutWebtoonViewController.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/08/01.
//

import UIKit
import SnapKit

class AboutWebtoonViewController: UIViewController {
    
    @IBOutlet weak var ivMain: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var tvEpisode: UITableView!
    
    var id : Int = 0
    var episodeData: [WebtoonEpisodeModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestTodayWebtoon()
        registerXib()
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "EpisodeTableViewCell", bundle: nil)
        tvEpisode.register(nibName, forCellReuseIdentifier: "EpisodeTableViewCell")
        tvEpisode.delegate = self
        tvEpisode.dataSource = self
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
                
                requestWebtoonEpisode()
            case .failure(let error):
                Log.e(error)
            }
        }
    }
    
    func requestWebtoonEpisode() {
        Repository().requestWebtoonEpisode(id: id) {[weak self] result in
            guard let `self` = self else {return}
            switch result {
            case .success(let data):
                Log.d(data)
                episodeData = data
                tvEpisode.snp.updateConstraints{
                    $0.height.equalTo((data?.count ?? 0) * 50)
                }
                tvEpisode.reloadData()
            case .failure(let error):
                Log.e(error)
            }
        }
    }
}
extension AboutWebtoonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodeData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as?
                EpisodeTableViewCell else {
            return UITableViewCell()
        }
        cell.ivMain.load(url: URL(string: episodeData?[indexPath.row].thumb ?? "")!)
        cell.lblTitle.text = episodeData?[indexPath.row].title ?? ""
        cell.lblRating.text = episodeData?[indexPath.row].rating ?? ""
        cell.lblDate.text = episodeData?[indexPath.row].date ?? ""
        return cell
    }
}
