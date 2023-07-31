//
//  APIInterceptor.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/07/31.
//

import Foundation
import Alamofire
// 요청을 가로채서 헤더를 추가하고 에러가 났을 때 재요청
// 1. ReqeustAdaptor: 요청되기 전에 Reqeust를 점검하고 변경할 수 있게 함
// 2. ReqeustRetrier: Reqesut에 에러가 발생했을 때, 재시도할 수 있게 해줌
class APIInterceptor: RequestInterceptor {
    // 에러가 발생했을 때만 실행
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < 1 else {
//            Log.d("API Retry Limited")
            completion(.doNotRetry)
            return
        }
        
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 500 {
//            Log.d("API Retry 500 Error")
            completion(.retryWithDelay(0.5))
            return
        }
        
        completion(.doNotRetry)
    }
}
