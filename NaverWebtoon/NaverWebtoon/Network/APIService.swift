//
//  APIService.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/07/31.
//

import Alamofire
import os

class APIService: BaseService {
    
    static let shared = APIService() // 싱글톤
    /// API 통신 요청.
    /// - Parameters:
    ///   - defaultAppToken: 기본 앱토큰 사용여부 (기본값 true)
    ///   - requestURL: 요청 url
    ///   - requestType: 요청 타입
    ///   - parameter: 요청  파라미터
    ///   - indicatorBgColor: 인디케이터 배경색
    ///   - completion: 통신 결과
    @discardableResult
    func requestApi<T: Decodable>(defaultAppToken: Bool = true, requestURL url : URL?, requestType type: HTTPMethod, parameters : Parameters = [:], indicatorShow: Bool = true, alertShow: Bool = true, modelType: T.Type, completion: @escaping (Result<T?,CommonAPIError>) -> Void) -> DataRequest? {
        
        //통신가능한 상태 체크
        guard Reachability.isConnectedToNetwork() else {
//            let vc = NetworkErrorPopupViewController.instantiate(storyboard: .NetworkError)
//            vc.retryCompletion = { [weak self] in
//                guard let `self` = self else {return}
//                self.requestApi(defaultAppToken: defaultAppToken, requestURL: url, requestType: type, parameters: parameters, indicatorShow: indicatorShow, alertShow: alertShow, modelType: modelType, completion: completion)
//            }
//            vc.modalPresentationStyle = .overFullScreen
//            vc.modalTransitionStyle = .crossDissolve
//            AppDelegate.applicationDelegate.navigationController?.topViewController?.topViewController()?.present(vc, animated: true, completion: nil)
            return nil
        }
        //URL 에러
        guard let requestUrl = url else {
            completion(.failure(.urlError))
            return nil
        }
        
        os_log("requestURL :\(requestUrl)")
        
        var encParameterBody: Parameters? = nil
        do {
            let encBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            let jsonString = String(data: encBody, encoding: .utf8)
            let jsonEncString = AESUtil.encrypt128(str: jsonString ?? "")
            //json암호화된 String값 value에 넣어서 body로 싣어 전송
            encParameterBody = ["param":jsonEncString ?? ""]
            
        } catch {
            completion(.failure(.paramEncryptError))
            return nil
        }
        os_log("requestURL :\(requestUrl) || parameter :\(parameters)")
        
        //공통헤더
        var header: HTTPHeaders = ["Content-Type": "application/json",
                                   "Accept": "application/json",
                                   "deviceType":"iphone"]
        
        return session.request(requestUrl,
                               method: type,
                               parameters: encParameterBody,
                               encoding: JSONEncoding.default,
                               headers: header,
                               interceptor: APIInterceptor()).response(queue: queue) { response in
            
            switch response.result {
            case .success(_) :
                if let responseData = response.data {
                    do {
                        //서버에서 전달받은 헤더 저장
                        if let authorization = response.response?.allHeaderFields["Authorization"] as? String {
                        }
                        //jsonData -> jsonString
                        let jsonString = String(data: responseData, encoding: .utf8)
                        
                        //json
                        let jsonDecString = AESUtil.decrypt128(str: jsonString ?? "")
                        os_log("jsonDecString : \(jsonDecString ?? "")")
                        guard let jsonDecData = jsonDecString?.data(using: .utf8) else {
                            os_log("jsonString : \(jsonString ?? "")")
                            //                            Alert.showOneButtonAlertController(title: "\(response.response?.statusCode) 에러") {
                            completion(.failure(CommonAPIError.networkError))
                            //                            }
                            return
                        }
                        //                        let decodeData = try JSONDecoder().decode(BaseResponseModel<T>.self, from: jsonDecData)
                        //                        os_log("requestUrl : \(requestUrl)\nResponseDataResult : \(decodeData)")
                        //                        let resultCode = ResultCode(rawValue: decodeData.resultCode ?? "")
                        //                        guard resultCode == .success || resultCode == .existInfo else {
                        //                            //토큰만료
                        //                            if resultCode == .failToken || resultCode == .noToken {
                        //                                //사용자 정보 초기화 및 로그아웃
                        //                                Alert.showOneButtonAlertController(title: decodeData.resultMessage ?? "유효하지 않은 토큰입니다.") {
                        //                                    if let navigatable = AppDelegate.applicationDelegate.navigationController?.topViewController as? BaseViewController {
                        //                                        navigatable.changeInitViewController(type: .SignIn)
                        //                                    }
                        //                                }
                        //                            } else { //그외 에러
                        //에러 메세지 노출 후 확인 버튼 터치시 처리
                        //                                if alertShow == true {
                        //                                    Alert.showOneButtonAlertController(title: decodeData.resultMessage ?? "알수 없는 에러") {
                        //                                        if Thread.isMainThread {
                        //                                            completion(.failure(.error(resultCode ?? .fail, decodeData.resultMessage ?? "알수 없는 에러")))
                        //                                        } else {
                        //                                            DispatchQueue.main.async {
                        //                                                completion(.failure(.error(resultCode ?? .fail, decodeData.resultMessage ?? "알수 없는 에러")))
                        //                                            }
                        //                                        }
                        //                                    }
                        //                                } else {
                        //                                    if Thread.isMainThread {
                        //                                        completion(.failure(.error(resultCode ?? .fail, decodeData.resultMessage ?? "알수 없는 에러")))
                        //                                    } else {
                        //                                        DispatchQueue.main.async {
                        //                                            completion(.failure(.error(resultCode ?? .fail, decodeData.resultMessage ?? "알수 없는 에러")))
                        //                                        }
                        //                                    }
                        //                                }
                        //                            }
                        //                            return
                        //                        }
                        //                        guard let resultData = decodeData.data else {
                        //                            //데이터 성공 이지만 data 없음
                        //                            //
                        //                            if Thread.isMainThread {
                        //                                completion(.success(nil))
                        //                            } else {
                        //                                DispatchQueue.main.async {
                        //                                    completion(.success(nil))
                        //                                }
                        //                            }
                        //                            return
                        //                        }
                        //
                        //                        //데이터 성공
                        //                        if Thread.isMainThread {
                        //                            completion(.success(resultData))
                        //                        } else {
                        //                            DispatchQueue.main.async {
                        //                                completion(.success(resultData))
                        //                            }
                        //                        }
                        //                    } catch let catchedError {
                        //                        if let decodeError = catchedError as? DecodingError {
                        //                            switch decodeError {
                        //                            case .keyNotFound(let key, let context):
                        //                                os_log("could not find key \(key) in JSON: \(context.debugDescription)")
                        //
                        //                            case .valueNotFound(let value, let context):
                        //                                os_log("could not find value \(value) in JSON: \(context.debugDescription)")
                        //
                        //                            case .typeMismatch(let type, let context):
                        //                                os_log("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                        //
                        //                            case .dataCorrupted(let context):
                        //                                os_log("data found to be corrupted in JSON: \(context.debugDescription)")
                        //
                        //                            default:
                        //                                os_log(decodeError.localizedDescription)
                        //                            }
                        //                        }
                        //                        //에러 메세지 노출 후 확인 버튼 터치시 처리
                        ////                        Alert.showOneButtonAlertController( title: catchedError.localizedDescription) {
                        ////                            completion(.failure(.jsonDecodeError))
                        ////                        }
                        //                    }
                        //                } else {
                        //                    //reponse data 누락
                        //                    completion(.failure(.jsonDecodeError))
                        //                }
                        //            case .failure(let error):
                        //                if error.responseCode == 1004 { //network error)
                        ////                    let vc = NetworkErrorPopupViewController.instantiate(storyboard: .NetworkError)
                        ////                    vc.retryCompletion = { [weak self] in
                        ////                        guard let `self` = self else {return}
                        ////                        self.requestApi(defaultAppToken: defaultAppToken, requestURL: url, requestType: type, parameters: parameters, indicatorShow: indicatorShow, alertShow: alertShow, modelType: modelType, completion: completion)
                        ////                    }
                        ////                    vc.modalPresentationStyle = .overFullScreen
                        ////                    vc.modalTransitionStyle = .crossDissolve
                        ////                    AppDelegate.applicationDelegate.navigationController?.topViewController?.topViewController()?.present(vc, animated: true, completion: nil)
                        //                } else {
                        //                    os_log("response failure \(error)")
                        //                    //네트워크 에러
                        ////                    Alert.showOneButtonAlertController( title: error.localizedDescription) {
                        ////                        completion(.failure(.networkError))
                        ////                    }
                        //                }
                        //            }
                        //        }
                        //    }
                        //}
                    }
