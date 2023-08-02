//
//  EpisodeTableViewCell.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/08/02.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var ivMain: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
