//
//  WebtoonInfoModel.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/08/01.
//

import Foundation

struct WebtoonInfoModel: Decodable {
    var title : String?
    var about : String?
    var genre : String?
    var age : String?
    var thumb : String?
}
