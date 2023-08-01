//
//  BaseService.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/07/31.
//

import Foundation
import Alamofire

class BaseService {
    lazy var session: Session = {
        // 헤더에 기본값 설정
        let configuration = URLSessionConfiguration.af.default
        // 타임아웃 시간 30초로 설정
        configuration.timeoutIntervalForRequest = 30
        // 세션 내의 task에서 사용하는 URL 캐시 객체 비활성화
        configuration.urlCache = nil
        // 로컬캐시 - 무시, 원본소스 - 무조건 접근
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        return Session(configuration: configuration)
    }()
  
    let queue = DispatchQueue(label: "network.queue", qos: .background, attributes: .concurrent)
}
