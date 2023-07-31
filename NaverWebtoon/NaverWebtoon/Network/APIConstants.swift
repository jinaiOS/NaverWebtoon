//
//  APIConstants.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/07/31.
//

import Foundation

struct APIConstants {
    
    /// 서버 도메인
    static let serverBaseURL = "https://webtoon-crawler.nomadcoders.workers.dev"
    
    static func withLink(_ link: String) -> URL? {
        let requestURLstr = APIConstants.serverBaseURL + link
        guard let encodedUrl = requestURLstr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrl) else { return nil }
        return url
    }
    
//    /// Returns today's comics (kids friendly)
//    static func todayComicsURL() -> URL? {
//        let requestURLstr = (APIConstants.serverBaseURL + "/today")
//        guard let url = URL(string: requestURLstr) else { return nil }
//        return url
//    }
//    
//    /// Returns a comic's information by `:id`
//    static func comicsInfoURL() -> URL? {
//        let requestURLstr = (APIConstants.serverBaseURL + "/id")
//        guard let url = URL(string: requestURLstr) else { return nil }
//        return url
//    }
//    
//    /// Returns the latest episodes for a comic by `:id`
//    static func lastestEpiURL() -> URL? {
//        let requestURLstr = (APIConstants.serverBaseURL + "/:id/episodes")
//        guard let url = URL(string: requestURLstr) else { return nil }
//        return url
//    }
}
