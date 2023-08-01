//
//  APIService.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/07/31.
//

import Alamofire

class APIService: BaseService {
    static let shared = APIService() // singleton
    
    /// API 통신 요청.
    /// - Parameters:
    ///   - defaultAppToken: 기본 앱토큰 사용여부 (기본값 true)
    ///   - requestURL: 요청 url
    ///   - requestType: 요청 타입
    ///   - parameter: 요청  파라미터
    ///   - indicatorBgColor: 인디케이터 배경색
    ///   - completion: 통신 결과
    // T: Type Parameter
    @discardableResult
    func requestApi<T: Decodable>(requestURL url : URL?, requestType type: HTTPMethod, parameters : Parameters = [:], modelType: T.Type, completion: @escaping (Result<T?,CommonAPIError>) -> Void) -> DataRequest? {
        //통신가능한 상태 체크
        guard Reachability.isConnectedToNetwork() else {
            return nil
        }
        // URL 에러
        guard let requestUrl = url else {
            completion(.failure(.urlError))
            return nil
        }
        
        Log.d("requestURL :\(requestUrl)")
        
        var request = URLRequest(url: requestUrl)
        
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("http Body Error")
        }
        
        Log.d("requestURL :\(requestUrl) || parameter :\(parameters)")
        
        //공통헤더
        let header: HTTPHeaders = ["Content-Type": "application/json",
                                   "Accept": "application/json",
                                   "deviceType":"iphone"]
        return session.request(requestUrl,
                               method: type,
                               parameters: parameters,
                               headers: header,
                               interceptor: APIInterceptor()).response(queue: queue) { response in
            
            switch response.result {
            case .success(_) :
                if let responseData = response.data {
                    do {
                       
                        //jsonData -> jsonString
                        let jsonString = String(data: responseData, encoding: .utf8)
                        Log.d(jsonString)
//                        let decoder = JSONDecoder()
//                                if let json = try? decoder.decode(BaseResponseModel<T>.self, from: responseData) {
//                              print(json) // hyeon
//                            }

//                        let decoded = try? JSONDecoder().decode(BaseResponseModel<T>.self, from: responseData)
//
//                        print(decoded)

                        guard let jsonDecData = jsonString?.data(using: .utf8) else {
                            Log.e("jsonString : \(jsonString ?? "")")
                            Alert.showOneButtonAlertController(title: "\(response.response?.statusCode) 에러") {
                                completion(.failure(CommonAPIError.networkError))
                            }
                            return
                        }
                        let decodeData = try JSONDecoder().decode(T.self, from: jsonDecData)
                        Log.d("requestUrl : \(requestUrl)\nResponseDataResult : \(decodeData)")

                        //데이터 성공
                        if Thread.isMainThread {
                            completion(.success(decodeData))
                        } else {
                            DispatchQueue.main.async {
                                completion(.success(decodeData))
                            }
                        }
                        // JSON 변환
                    } catch let catchedError {
                        //에러 메세지 노출 후 확인 버튼 터치시 처리
                        Alert.showOneButtonAlertController( title: catchedError.localizedDescription) {
                            completion(.failure(.jsonDecodeError))
                        }
                    }
                } else {
                    //reponse data 누락
                    completion(.failure(.jsonDecodeError))
                }
            case .failure(let error) :
                if error.responseCode == 1004 { //network error
//                    let vc = NetworkErrorPopupViewController.instantiate(storyboard: .NetworkError)
//                    vc.retryCompletion = { [weak self] in
//                        guard let `self` = self else {return}
//                        self.requestApi(defaultAppToken: defaultAppToken, requestURL: url, requestType: type, parameters: parameters, indicatorShow: indicatorShow, alertShow: alertShow, modelType: modelType, completion: completion)
//                    }
//                    vc.modalPresentationStyle = .overFullScreen
//                    vc.modalTransitionStyle = .crossDissolve
//                    AppDelegate.applicationDelegate.navigationController?.topViewController?.topViewController()?.present(vc, animated: true, completion: nil)
                } else {
                    Log.d("response failure \(error)")
                    //네트워크 에러
                    Alert.showOneButtonAlertController( title: error.localizedDescription) {
                        completion(.failure(.networkError))
                    }
                }
            }
        }
    }
}
