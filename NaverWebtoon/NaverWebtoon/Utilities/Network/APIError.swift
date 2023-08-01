//
//  APIError.swift
//  NaverWebtoon
//
//  Created by 김지은 on 2023/07/31.
//

import Foundation

//서버 API 에러 정의
enum CommonAPIError: Error, Equatable {
    case urlError // 유효하지 않은 url
    case tokenExpired // 토큰 만료
    case paramEncryptError // 파라미터 암호화 에러
    case jsonDecodeError // response data 디코드 에러
    case networkError //네트워크 통신에러 (status 200아닌 경우)
    case error(ResultCode, String) // 그외 서버에서 전달받은 모든 에러
}

//서버 Response status Code
enum ResultCode: String, Decodable {
    case success                 = "0000"   //정상 처리되었습니다.
    case fail                    = "0099"   //정상적으로 처리되지 않았습니다.
    case failToken               = "0098"   //계정이 만료되었습니다.
    case noToken                 = "0097"   //로그인 정보가 없습니다
//    case failBadRequest          = "0098"   //잘못된 요청 입니다.
//    case notMatchingPassword     = "0096"   //패스워드가 맞지 않습니다.
    case noAccount               = "0093"   //이미 가입된 회원 입니다.

    /// 로그인 관련
    case notAvailState           = "0081"   //계정상태를 확인해주세요.
    case failPassword            = "0082"   //비밀번호가 일치하지 않습니다.
    case noAuthInfo              = "0083"   //계정정보가 존재하지 않습니다.
    case existInfo               = "0086"   //계정이 존재합니다.
    case noExistInfo             = "0087"   //계정이 존재하지 않습니다.
    
    /// 회원상태 관련
    case quitWait                = "0071"   //탈퇴 대기 상태입니다.\n고객센터로 문의해주세요.
    case quitComplete            = "0072"   //회원탈퇴가 정상적으로 처리되었습니다.\n이용해 주셔서 고맙습니다.
    case accountRest             = "0073"   //계정이 휴면 상태입니다.\n고객센터로 문의해주세요.
    case accountLock             = "0074"   //계정이 잠금 상태입니다.\n고객센터로 문의해주세요.
    case alreadyExist            = "0075"   //동일한 카카오 계정이 존재합니다.
    
    /// 암복호화 관련
    case badParameter            = "0061"   //복호화 도중 오류가 발생했습니다.

    /// 파일관련
    case uploadSuccess           = "0051"   //파일 업로드가 정상 처리되었습니다.
    case uploadFail              = "0052"   //파일 업로드에 실패했습니다.
    case badFileName             = "0053"   //파일명에 특수문자는 사용할 수 없습니다<br/>(공백 및 !@#$%^&*,?=\\\":{}|<>)
    case uploadEmpty             = "0054"   //업로드할 파일이 존재하지 않습니다.
    case alreadyExistValidDate   = "0055"   //유효기간이 이미 설정 되어있는 파일입니다.
    case alreadyExistWritingDate = "0056"   //작성일이 이미 설정 되어있는 파일입니다.
}
